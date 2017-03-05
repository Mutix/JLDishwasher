//
//  ProductCellBuilder.swift
//  JLDishwasher
//
//  Created by Martin Oppetit on 05/03/2017.
//  Copyright © 2017 Appwise Ltd. All rights reserved.
//

import Foundation
import AlamofireImage

struct ProductCellBuilder {
    
    static func configure(_ cell: ProductCellType, withProduct product: ProductType) {
        
        cell.titleLabel?.text = product.title
        cell.priceLabel?.text = "£\(product.price)"
        
        guard let productImageURL = product.imageURL else { return }
        
        cell.imageView?.af_setImage(withURL: productImageURL,
                                    placeholderImage: nil,
                                    filter: nil,
                                    progress: nil,
                                    progressQueue: DispatchQueue.main,
                                    imageTransition: .crossDissolve(0.3),
                                    runImageTransitionIfCached: false,
                                    completion: nil)
    }
}
