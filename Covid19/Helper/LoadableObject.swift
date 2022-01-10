//
//  LoadableObject.swift
//  Covid19
//
//  Created by AbdelrahmanQasim on 1/9/22.
//

import Foundation
enum LoadingState<Value> {
    case idle
    case loading
    case failed(NetworkError)
    case loaded(Value)
}
protocol LoadableObject: ObservableObject {
    associatedtype Output
    var state: LoadingState<Output> { get }
    func load()
}
