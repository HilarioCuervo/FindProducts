//
//  HTTPClient.swift
//  FindProducts
//
//  Created by Hilario Cuervo on 06/02/2024.
//

import Combine
import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, Error>
}

extension HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, Error> {
        
        let session = URLSession(configuration: .default)
        
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems
                
        guard let url = urlComponents.url else {
            Log.error("Error trying to build url.")
            return Fail(error: RequestError.invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        Log.info("Request builded succesfully.")
        
        return session.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global())
            .tryMap { data, response in
                
                guard let response = response as? HTTPURLResponse else {
                    Log.error("Error trying to decode URLResponse.")
                    throw RequestError.noResponse
                }
                
                switch response.statusCode {
                    
                case 200, 201:
                    Log.info("Request data received succesfully")
                    return data
                    
                case 401, 403:
                    Log.error("Error \(response.statusCode) (Unauthorized) trying to execute request.")
                    throw RequestError.unauthorized
                    
                case 404:
                    Log.error("Error \(response.statusCode) (NotFound) trying to execute request.")
                    throw RequestError.notFound
                    
                case 500...599:
                    Log.error("Error \(response.statusCode) (Server) trying to execute request.")
                    throw RequestError.serverError
                    
                default:
                    Log.error("Error \(response.statusCode) (Unexpected) trying to execute request.")
                    throw RequestError.unexpectedStatusCode
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
