//
//  ProductViewModel.swift
//  FindProducts
//
//  Created by Hilario Cuervo on 09/02/2024.
//

import Combine
import Foundation

final class ProductViewModel: ObservableObject {
    
    @Published private(set) var product: Product?

    @Published private(set) var error: RequestError?
    @Published var showErrorAlert: Bool
    
    private var productId: String
    
    private var cancellables: Set<AnyCancellable>
    private let productService: ProductServiceable
    
    init(productId: String, productService: ProductServiceable) {
        Log.info("Initializing ViewModel")
        
        self.productId = productId
        self.showErrorAlert = false
        
        self.productService = productService
        self.cancellables = Set<AnyCancellable>()
        
        fetchProductDetail()
    }
    
    deinit {
        Log.info("Deinitializing ViewModel")
    }
}

// MARK: - Services

extension ProductViewModel {
    
    private func fetchProductDetail() {
        Log.info("Start fetching product detail")
        
        productService.getProductDetail(id: productId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                
                guard let self else { return }
                
                switch result {
                    
                case .finished:
                    Log.info("Fetch product detail finished succesfully")
                    break
                    
                case .failure(let error):
                    self.setError(error as? RequestError ?? .unexpectedStatusCode, showAlert: true)
                    
                    Log.error("Error trying to fetch product detail")
                }
            } receiveValue: { [weak self] product in
                guard let self else { return }
                Log.info("Product detail data received succesfully")
                
                self.product = product
            }
            .store(in: &cancellables)
    }
}

// MARK: - Support functions

extension ProductViewModel {
    
    func getCurrencyString() -> String? {
        let currencyString = product?.currencyId ?? .emptyText
        return product?.price?.toFormattedStringPrice(currency: currencyString)
    }
    
    func getProductURL() -> URL? {
        guard let stringUrl = product?.permalink, let url = URL(string: stringUrl) else {
            setError(.invalidURL, showAlert: true)
            return nil
        }
        
        return url
    }
    
    private func setError(_ type: RequestError, showAlert: Bool) {
        self.showErrorAlert = showAlert
        self.error = type
    }
}
