//
//  TrackService.swift
//  Covid19
//
//  Created by AbdelrahmanQasim on 1/10/22.
//

import Foundation
import Combine

protocol TrackServiceable {
    func tracking(startDate: String, endDate: String, countryName: String) -> AnyPublisher<Tracking, NetworkError>
}

class TrackService: TrackServiceable {
    
    private var networkRequest: Requestable
    private var environment: Environments = .news
    
  // inject this for testability
    init(networkRequest: Requestable = NativeRequestable(), environment: Environments = .tracking) {
        self.networkRequest = networkRequest
        self.environment = environment
    }

    func tracking(startDate: String, endDate: String, countryName: String) -> AnyPublisher<Tracking, NetworkError> {
        let endpoint = CovidServiceEndpoints.tracking(startDate: startDate, endDate: endDate, countryName: countryName)
        let request = endpoint.createRequest(environment: environment)
        return self.networkRequest.request(Tracking.self, request)
    }
}
