//
//  ContentService.swift
//  FirebaseNote
//
//  Created by Maruf on 19/4/26.
//

import FirebaseFirestore

class ContentService {
    
    static let shared = ContentService()
    private let db = Firestore.firestore()
    
    func fetchItems(collection: String, completion: @escaping ([ContentItem]) -> Void) {
        
        db.collection(collection).getDocuments { snapshot, error in
            
            guard let documents = snapshot?.documents else {
                completion([])
                return
            }
            
            let items = documents.map { doc in
                ContentItem(
                    id: doc.documentID,
                    title: doc["title"] as? String ?? "",
                    summary: doc["summary"] as? String ?? "",
                    details: doc["details"] as? String ?? ""
                )
            }
            
            completion(items)
        }
    }
}
