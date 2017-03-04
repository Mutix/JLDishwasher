//
//  ProductType.swift
//  JLDishwasher
//
//  Created by Martin Oppetit on 04/03/2017.
//  Copyright © 2017 Appwise Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol ProductType {
    
    var productID: String { get }
    var title: String { get }
    var price: String { get }
    var imageURL: URL? { get }
    
    init(json: JSON)
}
