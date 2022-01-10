//
//  HTTPMethod.swift
//  Covid19
//
//  Created by AbdelrahmanQasim on 1/9/22.
//

import Foundation
public enum HTTPMethod: String {
    case get
    case post
    case put
    case patch
    case delete
    
    public var name: String {
        return rawValue.uppercased()
    }
}
