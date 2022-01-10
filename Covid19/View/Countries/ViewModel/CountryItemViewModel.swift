//
//  CountryItemViewModel.swift
//  Covid19
//
//  Created by AbdelrahmanQasim on 1/9/22.
//

import Foundation
struct CountryItemViewModel: Identifiable {
    var id: String = UUID().uuidString
    private var country: Country
    
    init(country: Country) {
        self.country = country
    }
    
    var name: String {
        country.name ?? ""
    }
    
    var capital: String {
        country.capital ?? ""
    }
    
    var region: String {
        country.region ?? ""
    }
    
    var alpha2Code: String {
        country.alpha2Code ?? ""
    }
}
