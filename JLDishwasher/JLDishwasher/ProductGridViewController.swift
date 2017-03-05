//
//  ProductGridViewController.swift
//  JLDishwasher
//
//  Created by Martin Oppetit on 04/03/2017.
//  Copyright © 2017 Appwise Ltd. All rights reserved.
//

import UIKit

class ProductGridViewController: UIViewController {

    @IBOutlet weak var productGrid: UICollectionView!
    let dataSource = ProductGridDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureProductGrid()
        fetchProducts()
    }
    
    private func configureProductGrid() {
        let productCellNib = UINib.init(nibName: "ProductGridCell", bundle: nil)
        productGrid.register(productCellNib, forCellWithReuseIdentifier: "ProductGridCell")
        productGrid.dataSource = dataSource
    }
    
    private func fetchProducts() {
        
        let productSearchService = ProductSearchService()
        
        productSearchService.getProductsMatching(searchTerm: "Dishwasher") { (products, error) in
            
            guard let products = products, error == nil else {
                self.handleProductFetchError()
                return
            }
            
            self.handleSuccessfulProductFetch(products)
        }
    }
    
    private func handleProductFetchError() {
        let alert = UIAlertController(title: "Oops",
                                      message: "Sorry, we couldn't load any products right now, please try again",
                                      preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
    }
    
    private func handleSuccessfulProductFetch(_ products: [ProductType]) {
        updateDataSourceAndReloadGrid(products)
        updateNavigationTitle(productCount: products.count)
    }
    
    private func updateDataSourceAndReloadGrid(_ products: [ProductType]) {
        dataSource.products = products
        productGrid.reloadData()
    }
    
    private func updateNavigationTitle(productCount count: Int) {
        title = "Dishwashers (\(count))"
    }
}
