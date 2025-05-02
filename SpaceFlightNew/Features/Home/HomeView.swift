//
//  HomeView.swift
//  SpaceFlightNew
//
//  Created by Amini on 29/04/25.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()
    
    @State private var path = NavigationPath()
    @State private var selectedArticle: Article? = nil
    @State private var showAllArticles = false

    var body: some View {
        NavigationStack(path: $path) {
            Group {
                ScrollView {
                    VStack(alignment: .center, spacing: 20) {
                        Text(greetings())
                        
                        Text("Username")
                        
                        ArticlePreviewListView(title: "Articles",
                                               articles: viewModel.articles,
                                               onSelectedArticle: { article in path.append(article)},
                                               onSeeAll: { path.append(viewModel.articles)})
                        
                        ArticlePreviewListView(title: "Reports",
                                               articles: viewModel.reports,
                                               onSelectedArticle: { article in path.append(article)},
                                               onSeeAll: { path.append(viewModel.reports)})

                        ArticlePreviewListView(title: "Blogs",
                                               articles: viewModel.blogs,
                                               onSelectedArticle: { article in path.append(article)},
                                               onSeeAll: { path.append(viewModel.blogs)})

                    }
                }
            }
        }
        .onAppear(perform: {
            viewModel.fetchAllData()
        })
        .navigationDestination(for: Article.self) { article in
            
        }
        .navigationDestination(for: [Article].self) { articles in
            
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

#Preview {
    HomeView()
}
