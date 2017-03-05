//
//  ProductGridDataSourceTests.swift
//  JLDishwasher
//
//  Created by Martin Oppetit on 04/03/2017.
//  Copyright © 2017 Appwise Ltd. All rights reserved.
//

import XCTest
@testable import JLDishwasher

class ProductGridDataSourceTests: XCTestCase {
    
    var dataSource: ProductGridDataSource?
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func setUp() {
        super.setUp()
        dataSource = ProductGridDataSource()
    }
    
    func testItShouldExist() {
        dataSource = ProductGridDataSource()
        XCTAssertNotNil(dataSource)
    }
    
    func testReturnsOneSection() {
        let sectionCount = dataSource?.numberOfSections(in: collectionView)
        XCTAssertEqual(sectionCount, 1)
    }
    
    func testReturnsZeroRowsGivenNilProductList() {
        dataSource?.products = nil
        let rowCount = dataSource?.collectionView(collectionView, numberOfItemsInSection: 0)
        XCTAssertEqual(rowCount, 0)
    }
    
    func testReturnsZeroRowsGivenEmptyProductList() {
        dataSource?.products = []
        let rowCount = dataSource?.collectionView(collectionView, numberOfItemsInSection: 0)
        XCTAssertEqual(rowCount, 0)
    }
    
    func testReturnsOneRowGivenOneProduct() {
        dataSource?.products = [MockProduct()]
        let rowCount = dataSource?.collectionView(collectionView, numberOfItemsInSection: 0)
        XCTAssertEqual(rowCount, 1)
    }
    
    func testReturnsTwoRowsGivenTwoProducts() {
        dataSource?.products = [MockProduct(), MockProduct()]
        let rowCount = dataSource?.collectionView(collectionView, numberOfItemsInSection: 0)
        XCTAssertEqual(rowCount, 2)
    }
    
    func testReturnsCells() {
        let product = MockProduct()
        dataSource?.products = [product]
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = dataSource?.collectionView(collectionView, cellForItemAt: indexPath)
        XCTAssertNotNil(cell)
    }
}

struct MockProduct: ProductType {
    var productID: String { return "1" }
    var title: String { return "title" }
    var price: String { return "1.99" }
    var imageURL: URL? { return URL(string: "http://example.com") }
}
