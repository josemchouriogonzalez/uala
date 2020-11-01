//
//  NetworkService.swift
//  Ualá
//
//  Created by Jose Chourio on 11/1/20.
//  Copyright © 2020 Jose Chourio. All rights reserved.
//

import Foundation
import Combine

protocol NetworkServiceProviding {
    func execute<T: Decodable>(_ requestProvider: RequestProviding) -> AnyPublisher<T, Error>
}

protocol RequestProviding {
    var urlRequest: URLRequest { get set}
}

enum ServiceError: Error {
    case serverResponseError(Int, String)
    case unknown
}

enum DataFetchStatus {
    case ready (nextPage: Int)
    case loading (page: Int)
    case done
}

enum HTTPMethod: String {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case connect = "CONNECT"
    case options = "OPTIONS"
    case trace = "TRACE"
    case patch = "PATCH"
}

enum DataTaskError: Error {
    case invalidResponse, rateLimitted, serverBusy
}

struct NetworkService: NetworkServiceProviding {
    
    func execute<T>(_ requestProvider: RequestProviding) -> AnyPublisher<T, Error> where T : Decodable {
        return URLSession.shared.dataTaskPublisher(for: requestProvider.urlRequest)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else { throw ServiceError.unknown }
                let statusCode = httpResponse.statusCode
                let errorJsonResponse = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String:Any]
                var message = ""
                if let errorDictionary = errorJsonResponse {
                    if let errorMessage = errorDictionary["message"] {
                        message = errorMessage as! String
                    }
                }
                
                guard (200..<300).contains(statusCode) else {
                    if message.isEmpty {
                        throw ServiceError.unknown
                    } else {
                        throw ServiceError.serverResponseError(statusCode, message)
                    }
                    
                }
                return (data)
        }
        .mapError { return $0}
        .decode(type: T.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
    }
}



