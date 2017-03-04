//
//  URLRequestFactory.swift
//  JLDishwasher
//
//  Created by Martin Oppetit on 04/03/2017.
//  Copyright © 2017 Appwise Ltd. All rights reserved.
//

import Foundation

struct URLRequestFactory: URLRequestProviding {
    
    private let endpointProvider: APIProviding
    
    init(endpointProvider: APIProviding) {
        self.endpointProvider = endpointProvider
    }
    
    func generateProductSearchRequest(searchTerm: String, pageSize: Int) -> URLRequest? {
        guard let URL = endpointProvider.productSearchURL(query: searchTerm, pageSize: pageSize) else {
            return nil
        }
        return URLRequest(url: URL)
    }
}
