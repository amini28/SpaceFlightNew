//
//  ImageLoaderView.swift
//  SpaceFlightNew
//
//  Created by Amini on 30/04/25.
//
import SwiftUI

struct ImageLoaderView: View {
    let url: URL
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView() // Show a loading indicator
                
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()

            case .failure:
                Image(systemName: "Auth0")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                
            @unknown default:
                EmptyView()
            }
        }
    }
}


