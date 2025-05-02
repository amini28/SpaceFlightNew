//
//  ListView.swift
//  SpaceFlightNew
//
//  Created by Amini on 29/04/25.
//

import SwiftUI

struct ListView: View {
    
    let articles: [Article]
    
    @State private var searchText = ""
    @State private var selectedCategory: String = "All"
    @State private var showFilter: Bool = false
    let title = "Title"
    
    
    var newsSitesCatgories: [String] {
        articles.map { $0.newsSite ?? "" }
    }
    
    var filteredArticles: [Article] = []
    
    var body: some View {
        NavigationView {
            VStack {
                
                HStack {
                    TextField("Search cars...", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Spacer()
                    
                    Image(systemName: "line.3.horizontal.decrease")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .onTapGesture {
                            withAnimation {
                                showFilter.toggle()
                            }
                        }
                    
                    Image(systemName: "chevron.up.chevron.down.square.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                }
                .padding(.horizontal)
                
                if showFilter {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(newsSitesCatgories, id: \.self) { category in
                                Button(action: {
                                    selectedCategory = category
                                }) {
                                    Text(category)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 16)
                                        .background(selectedCategory == category ? Color.blue : Color.gray.opacity(0.3))
                                        .foregroundColor(.white)
                                        .cornerRadius(20)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
//                List (filteredArticles) { item in
//                    
//                }
//                .listStyle(PlainListStyle())
            }
            .navigationTitle(title)
        }
    }
}

//#Preview {
//    ListView()
//}

//struct ListView: View {
//    @ObservedObject var viewModel: ListViewModel
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                HStack {
//                    TextField("Search \(viewModel.title)...", text: $viewModel.searchText)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                    Spacer()
//
//                    Image(systemName: "line.3.horizontal.decrease")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 24, height: 24)
//                        .onTapGesture {
//                            withAnimation {
//                                viewModel.showFilter.toggle()
//                            }
//                        }
//                }
//                .padding(.horizontal)
//
//                if viewModel.showFilter {
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack {
//                            ForEach(viewModel.uniqueNewsSites, id: \.self) { category in
//                                Button(action: {
//                                    viewModel.selectedCategory = category
//                                }) {
//                                    Text(category)
//                                        .padding(.vertical, 8)
//                                        .padding(.horizontal, 16)
//                                        .background(viewModel.selectedCategory == category ? Color.blue : Color.gray.opacity(0.3))
//                                        .foregroundColor(.white)
//                                        .cornerRadius(20)
//                                }
//                            }
//                        }
//                        .padding(.horizontal)
//                    }
//                }
//
//                List(viewModel.filteredItemViewModels) { viewModel in
//                    HStack {
//                        if let url = viewModel.imageURL {
//                            ImageLoaderView(url: url)
//                                .frame(width: 80, height: 80)
//                        } else {
//                            Image(systemName: "photo")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 80, height: 80)
//                                .foregroundColor(.gray)
//                        }
//                        VStack(alignment: .leading) {
//                            Text(viewModel.title ?? "No Title")
//                                .font(.headline)
//                            Text(viewModel.newsSite ?? "Unknown Source")
//                                .font(.subheadline)
//                                .foregroundColor(.secondary)
//                            Text(viewModel.publishedAt ?? "No Date")
//                                .font(.caption)
//                                .foregroundColor(.gray)
//                        }
//                    }
//                }
//                .listStyle(PlainListStyle())
//            }
//            .navigationTitle(viewModel.title)
//        }
//    }
//}
