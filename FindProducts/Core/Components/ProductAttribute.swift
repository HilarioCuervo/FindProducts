//
//  ProductAttribute.swift
//  FindProducts
//
//  Created by Hilario Cuervo on 08/02/2024.
//

import SwiftUI

struct ProductAttribute: View {
    
    @State var textWidth: CGFloat = .zero
    
    var backgroundColor: Color
    var cornerRadius: CGFloat
    var fontSize: CGFloat
    var height: CGFloat
    var text: String
    var textColor: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .foregroundColor(backgroundColor)
                .frame(width: textWidth)
            Text(text)
                .font(.system(size: fontSize, weight: .semibold))
                .foregroundColor(textColor)
                .padding(.horizontal, 10)
                .overlay {
                    GeometryReader { proxy in
                        Color.clear.preference(key: TextWidthKey.self, value: proxy.size.width)
                    }
                }
        }
        .frame(height: height)
        .onPreferenceChange(TextWidthKey.self) { newTextWidth in
            textWidth = newTextWidth
        }
    }
}

struct TextWidthKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct FreeShippingPill_Previews: PreviewProvider {
    static var previews: some View {
        ProductAttribute(backgroundColor: .primaryColor,
                         cornerRadius: 8,
                         fontSize: 14,
                         height: 40,
                         text: "Envio gratis",
                         textColor: .white)
    }
}
