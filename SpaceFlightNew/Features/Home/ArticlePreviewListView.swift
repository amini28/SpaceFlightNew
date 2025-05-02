//
//  ArticlePreviewListView.swift
//  SpaceFlightNew
//
//  Created by Amini on 29/04/25.
//

import SwiftUI

struct ArticlePreviewListView: View {
    let title: String
    let articles: [Article]
    
    let onSelectedArticle: (Article) -> Void
    let onSeeAll: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Text("\(title)")
                    .font(.headline)
                
                Spacer()
                
                Button("See all") {
                    onSeeAll()
                }
            }
            .padding(.horizontal)

            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 10) {
                    ForEach(articles, id:\.self) { article in
                        thumbnailView(item: article)
                            .onTapGesture {
                                onSelectedArticle(article)
                            }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    @ViewBuilder
    private func thumbnailView(item: Article) -> some View {
        VStack {
            if let url = item.imageURL {
                ImageLoaderView(url: url)
                    .frame(width: 100, height: 100)
                    .background {
                        Color.gray.opacity(0.3)
                    }
                
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
                .lineLimit(2)
        }
        .frame(width: 100)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 2)
        }
    }
}

//// ViewModel for the ListView
//class ListViewModel: ObservableObject {
//    @Published var searchText = ""
//    @Published var selectedCategory = "All"
//    @Published var showFilter = false
//    @Published var itemViewModels: [ThumbViewModel] = []
//
//    private let allItems: [any ThumbData]
//
//    var uniqueNewsSites: [String] {
//        ["All"] + Array(Set(allItems.compactMap { $0.newsSite })).sorted()
//    }
//
//    var filteredItemViewModels: [ThumbViewModel] {
//        let filteredBySearch = itemViewModels.filter { viewModel in
//            searchText.isEmpty ||
//            (viewModel.title?.localizedCaseInsensitiveContains(searchText) ?? false) ||
//            (viewModel.newsSite?.localizedCaseInsensitiveContains(searchText) ?? false)
//        }
//
//        if selectedCategory == "All" {
//            return filteredBySearch
//        } else {
//            return filteredBySearch.filter { $0.newsSite == selectedCategory }
//        }
//    }
//
//    init(items: [any ThumbData], title: String) {
//        self.allItems = items
//        self.itemViewModels = items.map(ThumbViewModel.init)
//        self.title = title
//    }
//
//    let title: String
//}
