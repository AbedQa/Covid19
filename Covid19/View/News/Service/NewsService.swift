//
//  NewsService.swift
//  Covid19
//
//  Created by AbdelrahmanQasim on 1/9/22.
//

import SwiftUI
import Combine

protocol NewsServiceable {
    func news(countryName: String,category: String) -> AnyPublisher<News, NetworkError>
}

class NewsService: NewsServiceable {

    private var networkRequest: Requestable
    private var environment: Environments = .news
    
  // inject this for testability
    init(networkRequest: Requestable = NativeRequestable(), environment: Environments = .news) {
        self.networkRequest = networkRequest
        self.environment = environment
    }

    func news(countryName: String, category: String) -> AnyPublisher<News, NetworkError> {
        let endpoint = CovidServiceEndpoints.news(countryName: countryName, category: category)
        let request = endpoint.createRequest(environment: environment)
        return self.networkRequest.request(News.self, request)
    }
}
