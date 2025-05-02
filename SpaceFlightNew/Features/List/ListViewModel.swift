//
//  ListViewModel.swift
//  SpaceFlightNew
//
//  Created by Amini on 29/04/25.
//

import Foundation
import Combine

class ListViewModel: ObservableObject {
 
    @Published var articles: [Article] = []
    @Published var errorMessage: String?

    private let apiService: APIService
    private var cancellables = Set<AnyCancellable>()
    
    private var nextArticles: String?
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    func fetchData() {
        apiService.request(.getArticles)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("Error load articles: \(error)")
                }
            } receiveValue: { (articleResponse: ArticleResponse) in
                self.articles = articleResponse.results ?? []
                self.nextArticles = articleResponse.next
            }
            .store(in: &cancellables)

    }
}
