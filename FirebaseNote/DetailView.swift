//
//  DetailView.swift
//  FirebaseNote
//
//  Created by Maruf on 19/4/26.
//

import SwiftUI

struct DetailView: View {
    
    let item: ContentItem
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                
                Text(item.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text(item.details)
                    .font(.body)
                
            }
            .padding()
        }
        .navigationTitle("Details")
    }
}
