//
//  CovidServiceEndpoints.swift
//  Covid19
//
//  Created by AbdelrahmanQasim on 1/9/22.
//

import Foundation
public typealias Headers = [String: String]

enum CovidServiceEndpoints {
    
    case tracking(startDate: String, endDate: String, countryName: String)
    case news(countryName: String,category: String)
    case countries
    
    // gave a default timeout but can be different for each.
    var requestTimeOut: Int {
        return 20
    }
    
    //specify the type of HTTP request
    var httpMethod: HTTPMethod {
        switch self {
        case .countries,
                .news,
                .tracking:
            return .get
        }
    }
    
    // compose the NetworkRequest
    func createRequest(environment: Environments) -> NetworkRequest {
        var headers: Headers = [:]
        headers["Content-Type"] = "application/json"
        return NetworkRequest(url: getURL(from: environment), headers: headers, httpMethod: httpMethod)
    }
    
    
    // compose urls for each request
    func getURL(from environment: Environments) -> String {
        let baseUrl = environment.covidServiceBaseUrl
        switch self {
        case .countries:
            return "\(baseUrl)all?access_key=\(Constants.countryKey)"
        case .news(let countryName, let category):
            return "\(baseUrl)top-headlines?country=\(countryName)&category=\(category)&apiKey=\(Constants.newsApiKey)"
        case .tracking(let startDate, let endDate,let countryName):
            return "\(baseUrl)country/\(countryName)?date_from=\(startDate)&date_to=\(endDate)"
        }
    }
}
