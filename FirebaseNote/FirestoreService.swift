//
//  FirestoreService.swift
//  FirebaseNote
//
//  Created by Maruf on 18/4/26.
//

import FirebaseFirestore
import FirebaseAuth

class FirestoreService {
    
    static let shared = FirestoreService()
    private let db = Firestore.firestore()
    
    private init() {}
    
    func saveProfile(name: String, age: String, country: String, hobby: String, imageUrl: String?, completion: @escaping (Error?) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        var data: [String: Any] = [
            "name": name,
            "age": age,
            "country": country,
            "hobby": hobby,
            "email": Auth.auth().currentUser?.email ?? ""
        ]
        
        if let imageUrl = imageUrl {
            data["imageUrl"] = imageUrl
        }
        
        db.collection("users").document(uid).setData(data, merge: true) { error in
            completion(error)
        }
    }
    
    func fetchProfile(completion: @escaping (UserProfile?) -> Void) {
        
        // Get user UID
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // There users is the is the db folder of firestore where to get data
        db.collection("users").document(uid).getDocument { snapshot, error in
            
            guard let data = snapshot?.data() else {
                completion(nil)
                return
            }
            
            let profile = UserProfile(
                name: data["name"] as? String ?? "",
                age: data["age"] as? String ?? "",
                country: data["country"] as? String ?? "",
                hobby: data["hobby"] as? String ?? "",
                imageUrl: data["imageUrl"] as? String ?? ""
            )
            
            completion(profile)
        }
    }
}
