//
//  DateExtension.swift
//  Covid19
//
//  Created by AbdelrahmanQasim on 1/10/22.
//

import Foundation

extension String {
    func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ssZ")-> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        let date = dateFormatter.date(from: self)
        return date
    }
}

extension Date {
    func toString(format: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
