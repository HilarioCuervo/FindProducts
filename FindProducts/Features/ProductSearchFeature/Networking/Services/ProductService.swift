//
//  ProductService.swift
//  FindProducts
//
//  Created by Hilario Cuervo on 06/02/2024.
//

import Combine
import Foundation

protocol ProductServiceable {
    func getProductDetail(id: String) -> AnyPublisher<Product, Error>
    func searchProducts(name: String) -> AnyPublisher<Search, Error>
}

struct ProductService: HTTPClient, ProductServiceable {
    
    func getProductDetail(id: String) -> AnyPublisher<Product, Error> {
        return sendRequest(endpoint: ProductEndpoints.productDetail(productId: id))
    }
    
    func searchProducts(name: String) -> AnyPublisher<Search, Error> {
        return sendRequest(endpoint: ProductEndpoints.searchProducts(productName: name))
    }
}
