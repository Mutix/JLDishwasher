//
//  ProductGridCell.swift
//  JLDishwasher
//
//  Created by Martin Oppetit on 05/03/2017.
//  Copyright © 2017 Appwise Ltd. All rights reserved.
//

import UIKit
import AlamofireImage

class ProductGridCell: UICollectionViewCell, ProductCellType {

    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var priceLabel: UILabel?
    
    func configureWithProduct(_ product: ProductType) {
        
        titleLabel?.text = product.title
        priceLabel?.text = "£\(product.price)"
        
        if let productImageURL = product.imageURL {
            imageView?.af_setImage(withURL: productImageURL)
        }
    }
}
