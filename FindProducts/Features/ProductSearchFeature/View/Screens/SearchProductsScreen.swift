//
//  SearchProductsScreen.swift
//  FindProducts
//
//  Created by Hilario Cuervo on 04/02/2024.
//

import SwiftUI

struct SearchProductsScreen: View {
    
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    @StateObject var viewModel: SearchProductsViewModel
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack(spacing: 8) {
                    SearchBar(searchedText: $viewModel.searchedText,
                              height: 45,
                              width: proxy.size.width - 100,
                              iconSize: 22,
                              onSearch: viewModel.searchProducts)
                                    
                    ScrollView {
                        VStack(spacing: 22) {
                            ForEach(viewModel.products) { product in
                                NavigationLink(
                                    destination: ProductDetailScreen(
                                        viewModel: ProductViewModel(productId: product.id ?? .emptyText,
                                                                    productService: ProductService())
                                    )
                                ) {
                                    ProductRow(height: (verticalSizeClass == .regular) ? 180 : 130,
                                               width: proxy.size.width - 40,
                                               product: product)
                                }
                            }
                        }
                        .frame(maxWidth: .greatestFiniteMagnitude)
                        .padding(.top, 15)
                    }
                    .padding(.horizontal, 8)
                }
                .frame(width: proxy.size.width)
                .padding(.top, 30)
                .background(.white)
                .alert(isPresented: $viewModel.showErrorAlert, error: viewModel.error) { error in
                    
                    Button {
                        viewModel.showErrorAlert = false
                    } label: {
                        Text(String.acceptAlertText)
                    }
                } message: { error in
                    Text(error.message)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchProductsScreen(viewModel: SearchProductsViewModel(productService: ProductService()))
    }
}
