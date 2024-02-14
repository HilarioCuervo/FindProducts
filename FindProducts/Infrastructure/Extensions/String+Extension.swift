//
//  StringExtension.swift
//  FindProducts
//
//  Created by Hilario Cuervo on 05/02/2024.
//

import Foundation
import SwiftUI

// MARK: - Texts

extension String {
    static let acceptAlertText: String = "Entiendo"
    static let availableStockText: String = "Stock Disponible"
    static let buyProductText: String = "Comprar"
    static let emptyText: String = ""
    static let freeShippingText: String = "Envio Gratis"
    static let loadingCurrencyText: String = "$ ---"
    static let loadingText: String = "---"
    static let newProductText: String = "Nuevo"
    static let outOfStockText: String = "Sin Stock"
    static let usedProductText: String = "Usado"
}

// MARK: - Placeholders

extension String {
    static let textFieldPlaceholder: String = "Buscar"
}

// MARK: - Images and Icons names

extension String {
    static let closingCrossIcon: String = "xmark"
    static let emptyImageIcon: String = "photo"
    static let failImageIcon: String = "exclamationmark.circle"
    static let searchIcon: String = "magnifyingglass"
}

// MARK: - Networking related strings

extension String {
    static let scheme: String = "https"
    static let host: String = "api.mercadolibre.com"
}

// MARK: - Functions

extension String {
    public func toLocalizedStringKey() -> LocalizedStringKey {
        return LocalizedStringKey(self)
    }
}
