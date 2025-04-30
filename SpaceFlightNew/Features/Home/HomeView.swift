//
//  HomeView.swift
//  SpaceFlightNew
//
//  Created by Amini on 29/04/25.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            Group {
                ScrollView {
                    VStack(alignment: .center) {
                        Text(greetings())
                        
                        Text("Username")
                        
                        HorizontalThumbnails<Article>(items: viewModel.articles, urlKeyPath: \.imageURL)
                        HorizontalThumbnails<Report>(items: viewModel.reports, urlKeyPath: \.imageURL)
                        HorizontalThumbnails<Blog>(items: viewModel.blogs, urlKeyPath: \.imageURL)
                    }
                }
                .onAppear(perform: {
                    viewModel.fetchAllData()

                })
            }
        }
    }
    
    private func greetings() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12: return "Good Morning"
        case 12..<17: return "Good Afternoon"
        case 17..<22: return "Good Evening"
        default: return "Good Night"
        }
    }
}

//#Preview {
//    HomeView()
//}
