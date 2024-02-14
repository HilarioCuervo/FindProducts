//
//  Product.swift
//  FindProducts
//
//  Created by Hilario Cuervo on 06/02/2024.
//

import Foundation

struct Product: Codable, Identifiable {
    var id: String?
    var condition: String?
    var currencyId: String?
    var initialQuantity: Int?
    var permalink: String?
    var pictures: [Picture]?
    var price: Double?
    var shipping: Shipping?
    var status: String?
    var thumbnail: String?
    var title: String?
    var warranty: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case condition
        case currencyId = "currency_id"
        case initialQuantity = "initial_quantity"
        case permalink, pictures, price
        case shipping, status, thumbnail
        case title, warranty
    }
    
    public func conditionString() -> String {
        if self.isNew() { return .newProductText } else { return .usedProductText }
    }
    
    public func hasStock() -> Bool {
        return self.initialQuantity != nil && self.initialQuantity != 0
    }
    
    public func hasWarranty() -> Bool {
        guard let warranty = self.warranty else { return false }
        return self.warranty != "Sin garantía" && warranty.count < 40
    }
    
    private func isNew() -> Bool {
        return self.condition == "new"
    }
    
    public func stockString() -> String {
        if self.hasStock() { return .availableStockText } else { return .outOfStockText }
    }
}

struct Picture: Codable, Identifiable {
    var id: String?
    var url: String?
}

struct Shipping: Codable {
    var freeShipping: Bool?
    
    enum CodingKeys: String, CodingKey {
        case freeShipping = "free_shipping"
    }
}
