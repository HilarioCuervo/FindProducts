//
//  Endpoint.swift
//  FindProducts
//
//  Created by Hilario Cuervo on 06/02/2024.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var method: RequestMethod { get }
//    var header: [String: String]? { get }
//    var body: Data? { get }
}

extension Endpoint {
    var scheme: String {
        return .scheme
    }
    
    var host: String {
        return .host
    }
}
