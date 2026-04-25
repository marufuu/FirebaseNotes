//
//  LibraryView.swift
//  FirebaseNote
//
//  Created by Maruf on 19/4/26.
//

import SwiftUI

struct LibraryView: View {
    
    var body: some View {
        NavigationStack {   // ✅ ADD THIS
            
            VStack(spacing: 20) {
                
                Text("Library")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                NavigationLink("Movie Summaries") {
                    ContentListView(collection: "movies", title: "Movies")
                }
                .buttonStyle(.borderedProminent)
                
                NavigationLink("Book Summaries") {
                    ContentListView(collection: "books", title: "Books")
                }
                .buttonStyle(.bordered)
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    LibraryView()
}
