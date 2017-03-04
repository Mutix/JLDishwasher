//
//  URLRequestProviding.swift
//  JLDishwasher
//
//  Created by Martin Oppetit on 04/03/2017.
//  Copyright © 2017 Appwise Ltd. All rights reserved.
//

import Foundation

protocol URLRequestProviding {
    func generateProductSearchRequest(searchTerm: String, pageSize: Int) -> URLRequest?
}
