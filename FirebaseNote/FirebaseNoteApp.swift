//
//  FirebaseNoteApp.swift
//  FirebaseNote
//
//  Created by Maruf on 16/4/26.
//

import SwiftUI
import Firebase


@main
struct FirebaseNoteApp: App {
    
    init() {
          FirebaseApp.configure()
      }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
