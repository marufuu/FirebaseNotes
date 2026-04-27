//
//  RootView.swift
//  FirebaseNote
//
//  Created by Maruf on 16/4/26.
//

import SwiftUI
import FirebaseAuth

struct RootView: View {
    
    @State private var user: User?
    
    var body: some View {
        Group {
            if user != nil {
                HomeView()
            } else {
                LoginView()
            }
        }
        .onAppear {
            listenToAuthState()
        }
    }
    
    // Watches Firesbase's internal state
    func listenToAuthState() {
        Auth.auth().addStateDidChangeListener { _, user in
            self.user = user
            print("FN:listenToAuthState: called")
        }
    }
}

#Preview {
    RootView()
}
