//
//  NewsViewModel.swift
//  Covid19
//
//  Created by AbdelrahmanQasim on 1/9/22.
//

import Combine
import Foundation

class NewsViewModel: ObservableObject, LoadableObject {
    typealias Output = [ArticleViewModel]
    
    
    private var service: NewsServiceable
    private var articleViewModelList: [ArticleViewModel] = []
    private var disposables = Set<AnyCancellable>()

    @Published var countryName: String = "us"
    @Published var categorySelected = "business"
    @Published private(set) var state = LoadingState<[ArticleViewModel]>.idle

    private(set) var categoryList: [String] = [
        "business","entertainment","general","health","science","sports","technology"
    ]
    
    // inject this for testability
    init(service: NewsServiceable = NewsService(), countrySelectedItem: String) {
        self.service = service
        self.countryName = countrySelectedItem.substring(to: 2).uppercased()
    }
    
    func load() {
        state = .loading
        service.news(countryName: countryName, category: categorySelected)
            .map { $0.articles ?? [] }
            .replaceEmpty(with: [])
            .sink { response in
                switch response {
                case .failure(let error):
                    self.state = .failed(error)
                    break
                case .finished:
                    self.state = .loaded(self.articleViewModelList)
                }
            } receiveValue: { value in
                self.articleViewModelList = value.map { ArticleViewModel(article: $0) }
            }.store(in: &disposables)
    }
    
    func updateCountry(countryName: String) {
        self.countryName = countryName.lowercased()
        state = .idle
    }
    
    func updateCategorySelected(to category: String) {
        self.categorySelected = category
        state = .idle
    }
}

