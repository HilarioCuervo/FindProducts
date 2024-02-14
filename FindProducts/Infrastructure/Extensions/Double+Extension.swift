//
//  Double+Extension.swift
//  FindProducts
//
//  Created by Hilario Cuervo on 08/02/2024.
//

import Foundation

extension Double {
    public func toFormattedStringPrice(currency: String) -> String {
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = currency
        numberFormatter.currencyGroupingSeparator = "."
        numberFormatter.maximumFractionDigits = .zero

        return numberFormatter.string(from: NSNumber(value: self)) ?? "$ ---"
    }
}
