//
//  EndpointProvider.swift
//  JLDishwasher
//
//  Created by Martin Oppetit on 04/03/2017.
//  Copyright © 2017 Appwise Ltd. All rights reserved.
//

import Foundation

struct EndpointProvider: EndpointProviding {
    
    private let key: String
    private let scheme = "https"
    private let host = "api.johnlewis.com"
    private let productSearchPath = "/v1/products/search"
    
    init(key: String) {
        self.key = key
    }
    
    func productSearchURL(query: String, pageSize: Int) -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = productSearchPath
        components.queryItems = [searchQueryItem(query),
                                 APIKeyQueryItem(),
                                 pageSizeQueryItem(pageSize)]
        return components.url
    }
    
    private func searchQueryItem(_ query: String) -> URLQueryItem {
        return URLQueryItem(name: "q", value: query)
    }
    
    private func APIKeyQueryItem() -> URLQueryItem {
        return URLQueryItem(name: "key", value: key)
    }

    private func pageSizeQueryItem(_ pageSize: Int) -> URLQueryItem {
        return URLQueryItem(name: "pageSize", value: String(pageSize))
    }
}
