//
//  HomeView.swift
//  FirebaseNote
//
//  Created by Maruf on 18/4/26.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                // Header
                VStack(alignment: .leading, spacing: 5) {
                    Text("Welcome 👋")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    Text("InsightHub")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Cards
                VStack(spacing: 15) {
                    
                    NavigationLink {
                        ProfileView()
                    } label: {
                        HomeCardView(title: "My Profile", icon: "person.fill", color: .blue)
                    }
                    
                    NavigationLink {
                        LibraryView()
                    } label: {
                        HomeCardView(title: "Explore", icon: "book.fill", color: .green)
                    }
                    
                    NavigationLink {
                        Text("Next Feature")
                    } label: {
                        HomeCardView(title: "Next", icon: "sparkles", color: .orange)
                    }
                }
                
                Spacer()
                
                // Logout Button
                Button("Logout") {
                    logout()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(12)
                
            }
            .padding()
        }
    }
    
    func logout() {
        try? AuthService.shared.logout()
    }
}
