//
//  ProductSearchServiceTests.swift
//  JLDishwasher
//
//  Created by Martin Oppetit on 04/03/2017.
//  Copyright © 2017 Appwise Ltd. All rights reserved.
//

import XCTest
@testable import JLDishwasher

class ProductSearchServiceTests: XCTestCase {
    
    func testServiceReturnsNilProductsIfInvalidRequest() {
        
        let productSearcher = MockFailingProductFetcher(.invalidRequest)
        
        let service = ProductSearchService(productFetcher: productSearcher)
        
        let expectation = self.expectation(description: "Invalid request")
        
        service.getProductsMatching(searchTerm: "test") { (products, error) in
            XCTAssertNil(products)
            XCTAssertEqual(error, .invalidRequest)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testServiceReturnsNilProductsUponNetworkFailure() {
        
        let productSearcher = MockFailingProductFetcher(.requestFailed)
        
        let service = ProductSearchService(productFetcher: productSearcher)
        
        let expectation = self.expectation(description: "Failed request")
        
        service.getProductsMatching(searchTerm: "test") { (products, error) in
            XCTAssertNil(products)
            XCTAssertEqual(error, .requestFailed)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testServiceReturnsNilProductsUponResponseWithUnexpectedData() {
        
        let randomData = Data()
        let productFetcher = MockSuccessfulProductFetcher(randomData)
        
        let service = ProductSearchService(productFetcher: productFetcher)
        
        let expectation = self.expectation(description: "Bad data")
        
         service.getProductsMatching(searchTerm: "test") { (products, error) in
            XCTAssertNil(products)
            XCTAssertEqual(error, .invalidData)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testServiceReturnsCorrectProductCount() {
        
        guard let stubData = TestDataFactory.generateProductSearchResultsStubData() else {
            XCTFail("Could not load stub data")
            return
        }
        
        let productFetcher = MockSuccessfulProductFetcher(stubData)
        
        let service = ProductSearchService(productFetcher: productFetcher)
        
        let expectation = self.expectation(description: "Product count")
        
        service.getProductsMatching(searchTerm: "test") { (products, error) in
            XCTAssertEqual(products?.count, 3, "Service should return the correct number of products")
            XCTAssertNil(error, "Error should be nil")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testProductsCreatedCorrectly() {
        
        guard let stubData = TestDataFactory.generateProductSearchResultsStubData() else {
            XCTFail("Could not load stub data")
            return
        }
        
        let productFetcher = MockSuccessfulProductFetcher(stubData)
        
        let service = ProductSearchService(productFetcher: productFetcher)
        
        let expectation = self.expectation(description: "Product content")
        
        service.getProductsMatching(searchTerm: "test") { (products, error) in
            
            let firstProduct = products?.first
            XCTAssertNotNil(firstProduct)
            XCTAssertEqual(firstProduct?.productID, "1")
            XCTAssertEqual(firstProduct?.title, "Dishwasher 1")
            XCTAssertEqual(firstProduct?.price, "449.00")
            XCTAssertEqual(firstProduct?.imageURL, URL(string:"https://johnlewis.scene7.com/is/image/JohnLewis/1?"))
            
            let secondProduct = products?[1]
            XCTAssertNotNil(secondProduct)
            XCTAssertEqual(secondProduct?.productID, "2")
            XCTAssertEqual(secondProduct?.title, "Dishwasher 2")
            XCTAssertEqual(secondProduct?.price, "199.00")
            XCTAssertEqual(secondProduct?.imageURL, URL(string:"https://johnlewis.scene7.com/is/image/JohnLewis/2?"))
            
            let thirdProduct = products?[2]
            XCTAssertNotNil(thirdProduct)
            XCTAssertEqual(thirdProduct?.productID, "3")
            XCTAssertEqual(thirdProduct?.title, "Dishwasher 3")
            XCTAssertEqual(thirdProduct?.price, "249.00")
            XCTAssertEqual(thirdProduct?.imageURL, URL(string:"https://johnlewis.scene7.com/is/image/JohnLewis/3?"))
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}

private struct MockSuccessfulProductFetcher: ProductFetching {
    
    private var jsonDataResponse: Data
    
    init(_ data: Data) {
        self.jsonDataResponse = data
    }
    
    func fetchProductData(searchTerm: String, pageSize: Int, completion: @escaping ProductFetchCompletion) {
        completion(jsonDataResponse, nil)
    }
}

private struct MockFailingProductFetcher: ProductFetching {
    
    private var error: ProductFetchError?
    
    init(_ error: ProductFetchError? = nil) {
        self.error = error
    }
    
    func fetchProductData(searchTerm: String, pageSize: Int, completion: @escaping ProductFetchCompletion) {
        completion(nil, error)
    }
}
