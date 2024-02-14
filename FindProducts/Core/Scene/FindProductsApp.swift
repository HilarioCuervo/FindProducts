//
//  FindProductsApp.swift
//  FindProducts
//
//  Created by Hilario Cuervo on 04/02/2024.
//

import SwiftUI

@main
struct FindProductsApp: App {
    var body: some Scene {
        WindowGroup {
            SearchProductsScreen(viewModel: SearchProductsViewModel(productService: ProductService()))
        }
    }
}
