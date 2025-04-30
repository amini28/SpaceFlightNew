//
//  HorizontalThumbnails.swift
//  SpaceFlightNew
//
//  Created by Amini on 29/04/25.
//

import SwiftUI

struct HorizontalThumbnails<T: Hashable>: View {
    let items: [T]
    let urlKeyPath: KeyPath<T, URL?>
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 8) {
                ForEach(items, id: \.self) { item in
                    if let data = item as? ThumbData {
                        thumbnailView(item: data)
                            .frame(width: 100)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    private func thumbnailView(item: ThumbData) -> some View {
        VStack {
            if let url = item.imageURL {
                ThumbnailImage(url: url)
            } else {
                Image(systemName: "Auth0")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.gray)
            }
            
            Text("\(item.title ?? "No Title")")
                .font(.caption)
                .multilineTextAlignment(.center)
            
            Text("\(item.publishedAt ?? "-")")
                .font(.caption)
                .multilineTextAlignment(.center)
        }
    }
    
}




