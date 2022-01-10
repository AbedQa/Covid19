//
//  NativeRequestable.swift
//  Covid19
//
//  Created by AbdelrahmanQasim on 1/9/22.
//

import Foundation
import Combine

public protocol Requestable {
    var requestTimeOut: Float { get }
    
    func request<T: Codable>(_ decodeType: T.Type,_ req: NetworkRequest) -> AnyPublisher<T, NetworkError>
}

public class NativeRequestable: Requestable {
    public var requestTimeOut: Float = 30
    
    public func request<T>(_ decodeType: T.Type,_ req: NetworkRequest) -> AnyPublisher<T, NetworkError>
    where T: Codable {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(req.requestTimeOut ?? requestTimeOut)
        
        guard let url = URL(string: req.url) else {
            // Return a fail publisher if the url is invalid
            return AnyPublisher(
                Fail<T, NetworkError>(error: NetworkError.badURL("Invalid Url"))
            )
        }
        // We use the dataTaskPublisher from the URLSession which gives us a publisher to play around with.
        return URLSession.shared
            .dataTaskPublisher(for: req.buildURLRequest(with: url))
            .mapError { _ in NetworkError.noResponse("No Response") }
            .map { $0.data }
            .decode(type: decodeType, decoder: JSONDecoder())
            .mapError { NetworkError.invalidJSON($0.localizedDescription) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
