//
//  ContentListView.swift
//  FirebaseNote
//
//  Created by Maruf on 19/4/26.
//

import SwiftUI

struct ContentListView: View {
    
    let collection: String
    let title: String
    
    @State private var items: [ContentItem] = []
    
    var body: some View {
        
        // ❗ IMPORTANT: List must be the main view
        List(items) { item in
            
            NavigationLink {
                DetailView(item: item)
            } label: {
                VStack(alignment: .leading, spacing: 5) {
                    Text(item.title)
                        .font(.headline)
                    
                    Text(item.summary)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 5)
            }
        }
        .listStyle(.plain)
        .navigationTitle(title)
        .onAppear {
            fetchData()
        }
    }
    
    func fetchData() {
        ContentService.shared.fetchItems(collection: collection) { result in
            self.items = result
        }
    }
}
