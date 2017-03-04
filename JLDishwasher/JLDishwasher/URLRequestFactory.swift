//
//  URLRequestFactory.swift
//  JLDishwasher
//
//  Created by Martin Oppetit on 04/03/2017.
//  Copyright © 2017 Appwise Ltd. All rights reserved.
//

import Foundation

struct URLRequestFactory: URLRequestProviding {
    
    private let endpointProvider: EndpointProviding
    
    static func defaultInstance() -> URLRequestFactory {
        let defaultEndpointProvider = EndpointProvider(key: "Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb")
        return URLRequestFactory(endpointProvider: defaultEndpointProvider)
    }
    
    init(endpointProvider: EndpointProviding) {
        self.endpointProvider = endpointProvider
    }
    
    func generateProductSearchRequest(searchTerm: String, pageSize: Int) -> URLRequest? {
        guard let URL = endpointProvider.productSearchURL(query: searchTerm, pageSize: pageSize) else {
            return nil
        }
        return URLRequest(url: URL)
    }
}
