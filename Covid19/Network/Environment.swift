//
//  Environment.swift
//  Covid19
//
//  Created by AbdelrahmanQasim on 1/9/22.
//

import Foundation

public enum Environments: String, CaseIterable {
    case tracking
    case news
    case countries
}

extension Environments {
    var covidServiceBaseUrl: String {
        switch self {
        case .tracking:
            return "https://api.covid19tracking.narrativa.com/api/"
        case .news:
            return "https://newsapi.org/v2/"
        case .countries:
            return "http://api.countrylayer.com/v2/"
        }
    }
}
