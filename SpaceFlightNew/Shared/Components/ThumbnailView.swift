//
//  ThumbnailView.swift
//  SpaceFlightNew
//
//  Created by Amini on 30/04/25.
//
import SwiftUI

struct ThumbnailImage: View {
    let url: URL
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView() // Show a loading indicator
                
            case .success(let image):
                image
                    .resizable()
                    .frame(width: 80, height: 80)
                    .scaledToFill()

            case .failure:
                Image(systemName: "Auth0")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.gray)
                
            @unknown default:
                EmptyView()
            }
        }
    }
}


