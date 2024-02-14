//
//  ProductEndpoints.swift
//  FindProducts
//
//  Created by Hilario Cuervo on 06/02/2024.
//

import Foundation

enum ProductEndpoints {
    case productDetail(productId: String)
    case searchProducts(productName: String)
}

extension ProductEndpoints: Endpoint {

    var path: String {
        switch self {
        case .productDetail(let productId):
            return "/items/\(productId)"
        case .searchProducts:
            return "/sites/MLA/search"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .productDetail, .searchProducts:
            return .get
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .productDetail:
            return nil
        case .searchProducts(let productName):
            return [URLQueryItem(name: "q", value: productName)]
        }
    }
}
