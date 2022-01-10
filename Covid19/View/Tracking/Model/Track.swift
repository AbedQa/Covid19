//
//  Track.swift
//  Covid19
//
//  Created by AbdelrahmanQasim on 1/10/22.
//

import Foundation

// MARK: - Tracking
struct Tracking: Codable {
    let total: Total?
    
    enum CodingKeys: String, CodingKey {
        case total
    }
}

// MARK: - Total
struct Total: Codable {
    let date, id: String?
    let todayConfirmed, todayDeaths, todayNewConfirmed, todayNewDeaths: Int?
    let todayNewOpenCases, todayNewRecovered, todayOpenCases, todayRecovered: Int?
    
    enum CodingKeys: String, CodingKey {
        case date, id
        case todayConfirmed = "today_confirmed"
        case todayDeaths = "today_deaths"
        case todayNewConfirmed = "today_new_confirmed"
        case todayNewDeaths = "today_new_deaths"
        case todayNewOpenCases = "today_new_open_cases"
        case todayNewRecovered = "today_new_recovered"
        case todayOpenCases = "today_open_cases"
        case todayRecovered = "today_recovered"
    }
}
