//
//  EndpointProviding.swift
//  JLDishwasher
//
//  Created by Martin Oppetit on 04/03/2017.
//  Copyright © 2017 Appwise Ltd. All rights reserved.
//

import Foundation

protocol EndpointProviding {
    func productSearchURL(query: String, pageSize: Int) -> URL?
}
