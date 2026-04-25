//
//  EditProfileView.swift
//  FirebaseNote
//
//  Created by Maruf on 18/4/26.
//

import SwiftUI
import FirebaseStorage
import PhotosUI
import FirebaseAuth

struct EditProfileView: View {
    
    @State var name: String
    @State var age: String
    @State var country: String
    @State var hobby: String
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    
    @State private var message = ""
    
    var body: some View {
        VStack(spacing: 15) {
            
            Text("Update Profile")
                .font(.title)
                .fontWeight(.bold)
            
            TextField("Name", text: $name)
                .textFieldStyle(.roundedBorder)
            
            TextField("Age", text: $age)
                .textFieldStyle(.roundedBorder)
            
            TextField("Country", text: $country)
                .textFieldStyle(.roundedBorder)
            
            TextField("Hobby", text: $hobby)
                .textFieldStyle(.roundedBorder)
            
            
            PhotosPicker(selection: $selectedItem, matching: .images) {
                Text("Select Profile Image")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            
            
            Button("Update") {
                saveProfile()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            if !message.isEmpty {
                Text(message)
                    .foregroundColor(.green)
            }
            
            Spacer()
        }
        .padding()
        .onChange(of: selectedItem) { newItem in
            guard let newItem else { return }
            
            Task {
                do {
                    if let data = try await newItem.loadTransferable(type: Data.self) {
                        selectedImageData = data
                        print("maf Image selected ✅")
                    } else {
                        print("maf Failed to load image data ❌")
                    }
                } catch {
                    print("maf Picker error: \(error)")
                }
            }
        }
    }
    
    func uploadImage(completion: @escaping (String?) -> Void) {
        
        guard let data = selectedImageData,
              let uid = Auth.auth().currentUser?.uid else {
            print("No image or user ❌")
            completion(nil)
            return
        }
        
        let ref = Storage.storage().reference()
            .child("profile_images/\(uid).jpg")
        
        print("Starting upload... 🚀")
        
        ref.putData(data, metadata: nil) { metadata, error in
            
            if let error = error {
                print("Upload failed ❌: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            print("Upload success metadata: \(metadata?.path ?? "nil")")
            
            ref.downloadURL { url, error in
                
                if let error = error {
                    print("Download URL error ❌: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                
                print("Download URL success ✅: \(url?.absoluteString ?? "nil")")
                completion(url?.absoluteString)
            }
        }
    }

    func saveProfile() {
        // Validate inputs
        guard !name.isEmpty, !age.isEmpty, !country.isEmpty, !hobby.isEmpty else {
            message = "Please fill in all fields"
            return
        }
        
        message = "Saving profile..."
        
        // If there's an image, upload it first
        if let imageData = selectedImageData {
            uploadImage { imageUrl in
                DispatchQueue.main.async {
                    if let imageUrl = imageUrl {
                        self.saveToFirestore(imageUrl: imageUrl)
                    } else {
                        self.message = "Failed to upload image. Please try again."
                    }
                }
            }
        } else {
            // No image to upload, save profile without image
            saveToFirestore(imageUrl: nil)
        }
    }

    private func saveToFirestore(imageUrl: String?) {
        FirestoreService.shared.saveProfile(
            name: name,
            age: age,
            country: country,
            hobby: hobby,
            imageUrl: imageUrl
        ) { error in
            DispatchQueue.main.async {
                if let error = error {
                    message = "Error: \(error.localizedDescription)"
                    print("Firestore save error: \(error)")
                } else {
                    message = "Profile updated successfully! ✅"
                    
                    // Clear the selected image after successful save
                    selectedImageData = nil
                    selectedItem = nil
                    
                    // Optionally dismiss the view after a delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        // Navigate back if needed
                    }
                }
            }
        }
    }
}
