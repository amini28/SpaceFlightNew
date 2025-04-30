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
    @Published var reports: [Report] = []
    @Published var blogs: [Blog] = []
    
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
                    print("Error: \(error)")
                }
            }, receiveValue: { [weak self] (articleResponse: ArticleResponse) in
                self?.articles = articleResponse.results ?? []
            })
            .store(in: &cancellables)

        apiService.request(.getBlogs)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error: \(error)")
                }
            }, receiveValue: { [weak self] (blogResponse: BlogResponse) in
                self?.blogs = blogResponse.results ?? []
            })
            .store(in: &cancellables)

        apiService.request(.getReports)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error: \(error)")
                }
            }, receiveValue: { [weak self] (reportResponse: ReportsResponse) in
                self?.reports = reportResponse.results ?? []
            })
            .store(in: &cancellables)

    }
}
