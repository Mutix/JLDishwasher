//
//  Product.swift
//  JLDishwasher
//
//  Created by Martin Oppetit on 04/03/2017.
//  Copyright © 2017 Appwise Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Product: ProductType {
    
    var productID: String
    var title: String
    var price: String
    var imageURL: URL?
    
    init(json: JSON) {
        productID = json["productId"].stringValue
        title = json["title"].stringValue
        price = json["price"]["now"].stringValue
        imageURL = URL(string: "https:" + json["image"].stringValue)
    }
}
