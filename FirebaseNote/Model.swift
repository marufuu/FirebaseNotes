//
//  Model.swift
//  FirebaseNote
//
//  Created by Maruf on 18/4/26.
//

import Combine
import FirebaseFirestore

struct UserProfile {
    let name: String
    let age: String
    let country: String
    let hobby: String
    let imageUrl: String
}

struct ContentItem: Identifiable {
    var id: String
    var title: String
    var summary: String
    var details: String
}
