//
//  ProductCellType.swift
//  JLDishwasher
//
//  Created by Martin Oppetit on 05/03/2017.
//  Copyright © 2017 Appwise Ltd. All rights reserved.
//

import Foundation
import UIKit

protocol ProductCellType {
    
    var imageView: UIImageView? { get }
    var titleLabel: UILabel? { get }
    var priceLabel: UILabel? { get }
}
