//
//  NewsViewModel.swift
//  Covid19
//
//  Created by AbdelrahmanQasim on 1/9/22.
//

import Combine

class NewsViewModel: ObservableObject, LoadableObject {
    typealias Output = [ArticleViewModel]
    
    
    private var service: CovidServiceable
    private var articleViewModelList: [ArticleViewModel] = []
    private var disposables = Set<AnyCancellable>()

    @Published var countryName: String = "us"
    @Published var category: String = "business"
    @Published private(set) var state = LoadingState<[ArticleViewModel]>.idle
    
    // inject this for testability
    init(service: CovidServiceable = CovidService()) {
        self.service = service
    }
    
    func load() {
        state = .loading
        service.news(countryName: countryName, category: category)
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
}

