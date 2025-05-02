//
//  HomeViewModel.swift
//  SpaceFlightNew
//
//  Created by Amini on 29/04/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var articles: [Article] = []
    @Published var reports: [Article] = []
    @Published var blogs: [Article] = []
    
    @Published var errorMessage: String?

    private let apiService: APIService
    private var cancellables = Set<AnyCancellable>()
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    enum LoadingState {
        case idle, loading
    }
    
    func fetchAllData() {
        apiService.request(.getArticles)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error articles: \(error)")
                }
            }, receiveValue: { [weak self] (articleResponse: ArticleResponse) in
                self?.articles = articleResponse.results ?? []
            })
            .store(in: &cancellables)

        apiService.request(.getBlogs)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error blogs: \(error)")
                }
            }, receiveValue: { [weak self] (blogResponse: ArticleResponse) in
                self?.blogs = blogResponse.results ?? []
            })
            .store(in: &cancellables)

        apiService.request(.getReports)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error reports: \(error)")
                }
            }, receiveValue: { [weak self] (reportResponse: ArticleResponse) in
                self?.reports = reportResponse.results ?? []
            })
            .store(in: &cancellables)

    }
}
