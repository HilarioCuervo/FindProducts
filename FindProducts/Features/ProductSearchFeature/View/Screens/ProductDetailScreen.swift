//
//  ProductDetailScreen.swift
//  FindProducts
//
//  Created by Hilario Cuervo on 08/02/2024.
//

import SwiftUI

struct ProductDetailScreen: View {
    
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    @StateObject var viewModel: ProductViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                HStack {
                    Text(viewModel.product?.conditionString() ?? .loadingText)
                        .font(.subheadline)
                        .fontWeight(.light)
                    Spacer()
                }
                
                ImageSlider(pictures: viewModel.product?.pictures ?? [])
                    .frame(height: 360)
                
                if verticalSizeClass == .compact {
                    LandscapeDynamicView(viewModel: viewModel)
                }
                
                if verticalSizeClass == .regular {
                    PortraitDynamicView(viewModel: viewModel)
                }
                
                BuyButtonView(viewModel: viewModel)
                
                Spacer()
            }
            .padding(.horizontal, 30)
            .padding(.top, 20)
            .alert(isPresented: $viewModel.showErrorAlert, error: viewModel.error) { error in
                
                Button {
                    viewModel.showErrorAlert = false
                } label: {
                    Text(String.acceptAlertText)
                }
                
            } message: { error in
                Text(error.message)
                Image(systemName: .closingCrossIcon)
                    .resizable()
                    .foregroundColor(.red)
            }
        }
    }
}

private struct TitleView: View {
    
    @ObservedObject var viewModel: ProductViewModel
    
    var body: some View {
        Text(viewModel.product?.title ?? .loadingText)
            .font(.title2)
            .fontWeight(.regular)
            .lineLimit(5)
    }
}

private struct PriceView: View {
    
    @ObservedObject var viewModel: ProductViewModel
    
    var body: some View {
        Text(viewModel.getCurrencyString() ?? .loadingCurrencyText)
            .font(.title)
            .fontWeight(.semibold)
    }
}

private struct StockView: View {
    
    @ObservedObject var viewModel: ProductViewModel
    
    var body: some View {
        Text(viewModel.product?.stockString() ?? .loadingText)
            .font(.headline)
            .fontWeight(.light)
    }
}

private struct AttributesView: View {
    
    @ObservedObject var viewModel: ProductViewModel
    
    var alignment: HorizontalAlignment
    var spacing: CGFloat
    
    var body: some View {
        VStack(alignment: alignment, spacing: spacing) {
            if (viewModel.product?.shipping?.freeShipping ?? false) {
                ProductAttribute(backgroundColor: .primaryColor,
                                 cornerRadius: 8,
                                 fontSize: 12,
                                 height: 30,
                                 text: .freeShippingText,
                                 textColor: .white)
            }
            if (viewModel.product?.hasWarranty() ?? false) {
                ProductAttribute(backgroundColor: .secondaryColor,
                                 cornerRadius: 8,
                                 fontSize: 12,
                                 height: 30,
                                 text: viewModel.product?.warranty ?? .emptyText,
                                 textColor: .white)
            }
        }
    }
}

private struct BuyButtonView: View {
    
    @Environment(\.openURL) private var openUrl

    @ObservedObject var viewModel: ProductViewModel
    
    var body: some View {
        Button {
            if let url = viewModel.getProductURL() { openUrl(url) }
        } label: {
            Text(String.buyProductText.toLocalizedStringKey())
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.horizontal, 30)
                .padding(.vertical, 6)
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.capsule)
        .foregroundColor(.primaryColor)
        .disabled(!(viewModel.product?.hasStock() ?? false))
        .padding(.top, 30)
    }
}

// MARK: - Dynamic views based on phone orientation

private struct PortraitDynamicView: View {
    
    @ObservedObject var viewModel: ProductViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                TitleView(viewModel: viewModel)
                
                PriceView(viewModel: viewModel)
                
                StockView(viewModel: viewModel)
            }
            Spacer()
        }
        .padding(.top, 8)
        
        HStack {
            AttributesView(viewModel: viewModel, alignment: .leading, spacing: 8)
            Spacer()
        }
        .padding(.top, 8)
    }
}

private struct LandscapeDynamicView: View {
    
    @ObservedObject var viewModel: ProductViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                TitleView(viewModel: viewModel)
            }
            Spacer()
        }
        .padding(.top, 8)
        
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                PriceView(viewModel: viewModel)
                
                StockView(viewModel: viewModel)
            }
            Spacer()
            AttributesView(viewModel: viewModel, alignment: .trailing, spacing: 12)
        }
    }
}

struct ProductDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailScreen(viewModel: ProductViewModel(productId: "MLA1405624529",
                                                        productService: ProductService()))
        
        ProductDetailScreen(viewModel: ProductViewModel(productId: "MLA1407624529",
                                                        productService: ProductService()))
    }
}
