//
//  ProductRow.swift
//  FindProducts
//
//  Created by Hilario Cuervo on 08/02/2024.
//

import SwiftUI

struct ProductRow: View {
    
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    var height: CGFloat
    var width: CGFloat
    
    var product: Product
    
    var body: some View {
        HStack(spacing: 20) {
            URLImageView(urlString: product.thumbnail)
                .frame(width: 110, height: height * 0.8)
            
            VStack(alignment: .leading, spacing: 20) {
                Text(product.title ?? .loadingText)
                    .font(.system(size: 18, weight: .light))
                    .foregroundColor(.black)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                
                if verticalSizeClass == .regular {
                    PortraitDynamicView(product: product)
                } else {
                    LandscapeDynamicView(product: product)
                }
            }
            
            Spacer()
        }
        .padding(15)
        .frame(width: width, height: height)
        .background(.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 12, x: 1, y: 1)
        .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
    }
}

private struct PriceView: View {
    
    var product: Product
    
    var body: some View {
        Text(product.price?.toFormattedStringPrice(currency: product.currencyId ?? .emptyText) ?? .loadingCurrencyText)
            .font(.system(size: 20, weight: .medium))
            .foregroundColor(.black)
    }
}

private struct FreeShippingView: View {
    
    var product: Product
    
    var body: some View {
        if (product.shipping?.freeShipping ?? false) {
            ProductAttribute(backgroundColor: .primaryColor,
                             cornerRadius: 8,
                             fontSize: 12,
                             height: 28,
                             text: .freeShippingText,
                             textColor: .white)
        }
    }
}

// MARK: - Dynamic views based on phone orientation

private struct PortraitDynamicView: View {
    
    var product: Product
    
    var body: some View {
        PriceView(product: product)
        FreeShippingView(product: product)
    }
}

private struct LandscapeDynamicView: View {
    
    var product: Product
    
    var body: some View {
        HStack {
            PriceView(product: product)
            Spacer()
            FreeShippingView(product: product)
        }
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(height: 180,
                   width: 360,
                   product: Product(id: "MLA1407624529",
                                    condition: "used",
                                    currencyId: "ARS",
                                    initialQuantity: nil,
                                    pictures: nil,
                                    price: 700000,
                                    shipping: Shipping(freeShipping: true),
                                    status: "active",
                                    thumbnail: "http://http2.mlstatic.com/D_724385-MLA74331925070_022024-I.jpg",
                                    title: "iPhone 13 mini 128gb Midnight",
                                    warranty: "Sin Garantia"))
    }
}
