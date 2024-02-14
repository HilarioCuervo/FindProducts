//
//  SearchProductsViewModel.swift
//  FindProducts
//
//  Created by Hilario Cuervo on 07/02/2024.
//

import Combine
import Foundation

final class SearchProductsViewModel: ObservableObject {
    
    @Published private(set) var products: [Product]
    @Published var searchedText: String
    
    @Published private(set) var error: RequestError?
    @Published var showErrorAlert: Bool

    private var cancellables: Set<AnyCancellable>
    private let productService: ProductServiceable
    
    init(productService: ProductServiceable) {
        Log.info("Initializing ViewModel")
        
        self.products = []
        self.searchedText = .emptyText
        self.showErrorAlert = false
        
        self.productService = productService
        self.cancellables = Set<AnyCancellable>()
    }
    
    deinit {
        Log.info("Deinitializing ViewModel")
    }
}

// MARK: - Services

extension SearchProductsViewModel {
    
    func searchProducts() {
        
        guard !searchedText.isEmpty else {
            setError(.noInput, showAlert: true)
            Log.error("Error receiving empty input text")
            return
        }
        
        Log.info("Start searching products")
        
        productService.searchProducts(name: searchedText)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                guard let self else { return }
                
                switch result {
                    
                case .finished:
                    Log.info("Search products finished succesfully")
                    break
                    
                case .failure(let error):
                    self.setError(error as? RequestError ?? .unexpectedStatusCode, showAlert: true)
                    
                    Log.error("Error trying to search products")
                }
                
            } receiveValue: { [weak self] search in
                guard let self else { return }
                
                self.products = search.results ?? []
                
                if self.products.isEmpty {
                    Log.error("Error receiving empty results for the search")
                    
                    setError(.noResponse, showAlert: true)
                } else {
                    Log.info("Search results data received succesfully")
                }
            }
            .store(in: &cancellables)
    }
}

// MARK: - Support functions

extension SearchProductsViewModel {
    private func setError(_ type: RequestError, showAlert: Bool) {
        self.showErrorAlert = showAlert
        self.error = type
    }
}
