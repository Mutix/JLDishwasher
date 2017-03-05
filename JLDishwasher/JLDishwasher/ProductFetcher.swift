//
//  ProductFetcher.swift
//  JLDishwasher
//
//  Created by Martin Oppetit on 04/03/2017.
//  Copyright © 2017 Appwise Ltd. All rights reserved.
//

import Foundation

struct ProductFetcher: ProductFetching {
    
    private let session: URLSession
    private let requestFactory: URLRequestProviding
    
    init(requestFactory: URLRequestProviding, session: URLSession? = nil) {
        self.requestFactory = requestFactory
        self.session = session ?? URLSession.shared
    }
    
    func fetchProductData(searchTerm: String, pageSize: Int, completion: @escaping ProductFetchCompletion) {
        
        guard let request = requestFactory.generateProductSearchRequest(searchTerm: searchTerm, pageSize: pageSize) else {
            completion(nil, ProductFetchError.invalidRequest)
            return
        }
        
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard error == nil else {
                completion(nil, ProductFetchError.requestFailed)
                return
            }
            completion(data, nil)
        })
        
        dataTask.resume()
    }
}
