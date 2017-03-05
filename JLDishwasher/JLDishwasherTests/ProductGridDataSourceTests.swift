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
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
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
        dataSource?.products = [MockProductA()]
        let rowCount = dataSource?.collectionView(collectionView, numberOfItemsInSection: 0)
        XCTAssertEqual(rowCount, 1)
    }
    
    func testReturnsTwoRowsGivenTwoProducts() {
        dataSource?.products = [MockProductA(), MockProductB()]
        let rowCount = dataSource?.collectionView(collectionView, numberOfItemsInSection: 0)
        XCTAssertEqual(rowCount, 2)
    }
    
    func testReturnsDequeuedCells() {
        let stubCell = MockProductCell()
        collectionView = MockCollectionView(stubbingDequeuedCell: stubCell)
        dataSource?.products = [MockProductA()]
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = dataSource?.collectionView(collectionView, cellForItemAt: indexPath)
        XCTAssertEqual(cell, stubCell)
    }
    
    func testReturnsConfiguredProductCells() {
        let stubCell = MockProductCell()
        let imageView = UIImageView(frame: .zero)
        let titleLabel = UILabel(frame: .zero)
        let priceLabel = UILabel(frame: .zero)
        stubCell.imageView = imageView
        stubCell.titleLabel = titleLabel
        stubCell.priceLabel = priceLabel
        
        collectionView = MockCollectionView(stubbingDequeuedCell: stubCell)
        dataSource?.products = [MockProductA(), MockProductB()]
        let firstIndexPath = IndexPath(item: 0, section: 0)
        let firstCell = dataSource?.collectionView(collectionView, cellForItemAt: firstIndexPath) as? ProductCellType
        XCTAssertEqual(firstCell?.titleLabel?.text, "title A")
        XCTAssertEqual(firstCell?.priceLabel?.text, "£1.99")
        
        let secondIndexPath = IndexPath(item: 1, section: 0)
        let secondCell = dataSource?.collectionView(collectionView, cellForItemAt: secondIndexPath) as? ProductCellType
        XCTAssertEqual(secondCell?.titleLabel?.text, "title B")
        XCTAssertEqual(secondCell?.priceLabel?.text, "£2.99")
    }
}

struct MockProductA: ProductType {
    var productID: String { return "A" }
    var title: String { return "title A" }
    var price: String { return "1.99" }
    var imageURL: URL? { return URL(string: "http://example.com/a.png") }
}

struct MockProductB: ProductType {
    var productID: String { return "B" }
    var title: String { return "title B" }
    var price: String { return "2.99" }
    var imageURL: URL? { return URL(string: "http://example.com/b.png") }
}

class MockCollectionView: UICollectionView {
    
    var stubbedCell: MockProductCell
    
    init(stubbingDequeuedCell cell: MockProductCell) {
        stubbedCell = cell
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
        return stubbedCell
    }
}

class MockProductCell: ProductGridCell { }
