//
//  ProductFetching.swift
//  JLDishwasher
//
//  Created by Martin Oppetit on 04/03/2017.
//  Copyright © 2017 Appwise Ltd. All rights reserved.
//

import Foundation

enum ProductFetchError: Error {
    case invalidRequest
    case requestFailed
}

typealias ProductFetchCompletion = (_ data: Data?, _ error: ProductFetchError?) -> Void

protocol ProductFetching {
    
    func fetchProductData(searchTerm: String,
                          pageSize: Int,
                          completion: @escaping ProductFetchCompletion)
}
