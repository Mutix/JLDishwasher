//
//  RemoteProductSearching.swift
//  JLDishwasher
//
//  Created by Martin Oppetit on 04/03/2017.
//  Copyright © 2017 Appwise Ltd. All rights reserved.
//

import Foundation

enum RemoteProductSearchError: Error {
    case invalidRequest
    case requestFailed
}

typealias RemoteProductSearchCompletion = (_ data: Data?, _ error: RemoteProductSearchError?) -> Void

protocol RemoteProductSearching {
    
    func getRemoteProductData(searchTerm: String,
                              pageSize: Int,
                              completion: @escaping RemoteProductSearchCompletion)
}
