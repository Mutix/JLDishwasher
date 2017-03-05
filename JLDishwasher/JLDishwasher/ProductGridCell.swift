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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.af_cancelImageRequest()
        imageView?.image = nil
    }
}
