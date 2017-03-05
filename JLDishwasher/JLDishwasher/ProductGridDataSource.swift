//
//  ProductGridDataSource.swift
//  JLDishwasher
//
//  Created by Martin Oppetit on 04/03/2017.
//  Copyright © 2017 Appwise Ltd. All rights reserved.
//

import Foundation
import UIKit

class ProductGridDataSource: NSObject, UICollectionViewDataSource {
    
    var products: [ProductType]?
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let products = products else { return 0 }
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductGridCell", for: indexPath)
        
        if let product = products?[indexPath.row], let cell = cell as? ProductCellType {
            ProductCellBuilder.configure(cell, withProduct: product)
        }
        
        return cell
    }
}
