//
//  HomeView.swift
//  FirebaseNote
//
//  Created by Maruf on 16/4/26.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var name = ""
    @State private var age = ""
    @State private var country = ""
    @State private var hobby = ""
    @State private var imageUrl = ""
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Avatar + Title
            VStack(spacing: 10) {
                
                
                if let url = URL(string: imageUrl), !imageUrl.isEmpty {
                    AsyncImage(url: url) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                }
                
                Text(name.isEmpty ? "Your Name" : name)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            
            // Info Section
            VStack(spacing: 12) {
                ProfileRow(title: "Age", value: age)
                ProfileRow(title: "Country", value: country)
                ProfileRow(title: "Hobby", value: hobby)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(16)
            
            // Update Button
            NavigationLink("Update Profile") {
                EditProfileView(
                    name: name,
                    age: age,
                    country: country,
                    hobby: hobby
                )
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(12)
            
            Spacer()
        }
        .padding()
        .onAppear {
            loadProfile()
        }
    }
    
    func loadProfile() {
        FirestoreService.shared.fetchProfile { profile in
            if let profile = profile {
                name = profile.name
                age = profile.age
                country = profile.country
                hobby = profile.hobby
                imageUrl = profile.imageUrl
            }
        }
    }
}

#Preview {
    ProfileView()
}
