//
//  ProductSearchService.swift
//  JLDishwasher
//
//  Created by Martin Oppetit on 04/03/2017.
//  Copyright © 2017 Appwise Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

enum ProductSearchServiceError: Error {
    case invalidRequest
    case requestFailed
    case invalidData
}

typealias ProductSearchServiceCompletion = (_ products: [ProductType]?, _ error: ProductSearchServiceError?) -> Void

struct ProductSearchService {
    
    private let requestFactory: URLRequestFactory
    private let productSearcher: RemoteProductSearching
    
    init(requestFactory: URLRequestFactory? = nil, productSearcher: RemoteProductSearching? = nil) {
        let requestFactory = requestFactory ?? URLRequestFactory.defaultInstance()
        let productSearcher = productSearcher ?? ProductSearcher(requestFactory: requestFactory)
        self.requestFactory = requestFactory
        self.productSearcher = productSearcher
    }
    
    func getProductsMatching(searchTerm: String, completion: @escaping ProductSearchServiceCompletion) {
        
        let defaultPageSize = 20
        
        productSearcher.getRemoteProductData(searchTerm: searchTerm, pageSize: defaultPageSize) { (data, error) in
            
            if let error = error {
                switch error {
                case .invalidRequest:
                    self.complete(completion, products: nil, error: .invalidRequest)
                    break
                case .requestFailed:
                    self.complete(completion, products: nil, error: .requestFailed)
                    break
                }
                return
            }
            
            guard let data = data, let products = self.productsFromData(data) else {
                self.complete(completion, products: nil, error: .invalidData)
                return
            }
            
            self.complete(completion, products: products, error: nil)
        }
    }
    
    private func complete(_ completion: @escaping ProductSearchServiceCompletion, products: [ProductType]?, error: ProductSearchServiceError?) {
        DispatchQueue.main.async {
            completion(products, error)
        }
    }
    
    private func productsFromData(_ data: Data) -> [ProductType]? {
        let json = JSON(data: data)
        return json["products"].array?.map() { Product(json: $0) }
    }
}
