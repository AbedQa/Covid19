//
//  CountryService.swift
//  Covid19
//
//  Created by AbdelrahmanQasim on 1/9/22.
//

import Foundation
import Combine

protocol CountryServiceable {
    func countries() -> AnyPublisher<[Country], NetworkError>
}

class CountryService: CountryServiceable {
    
    private var networkRequest: Requestable
    private var environment: Environments = .news
    
  // inject this for testability
    init(networkRequest: Requestable = NativeRequestable(), environment: Environments = .countries) {
        self.networkRequest = networkRequest
        self.environment = environment
    }

    func countries() -> AnyPublisher<[Country], NetworkError> {
        let endpoint = CovidServiceEndpoints.countries
        let request = endpoint.createRequest(environment: environment)
        return self.networkRequest.request([Country].self, request)
    }
}
