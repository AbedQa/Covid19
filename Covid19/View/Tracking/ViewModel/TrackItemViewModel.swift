//
//  TrackItemViewModel.swift
//  Covid19
//
//  Created by AbdelrahmanQasim on 1/10/22.
//

import Foundation

class TrackItemViewModel: Identifiable {
    var id: String = UUID().uuidString
    private var casesNumber: Int?
    private var image: String
    private var title: String

    init(casesNumber: Int?,image: String,title: String) {
        self.casesNumber = casesNumber
        self.image = image
        self.title = title
    }
    
    var trackCases: String {
        "\((casesNumber ?? 0).abbreviated)"
    }
    
    var trackImage: String {
        "\(self.image)"
    }
    
    var trackTitle: String {
        "\(self.title)"
    }
}
