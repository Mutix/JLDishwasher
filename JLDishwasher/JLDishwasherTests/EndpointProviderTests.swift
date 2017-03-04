//
//  EndpointProviderTests.swift
//  JLDishwasher
//
//  Created by Martin Oppetit on 04/03/2017.
//  Copyright © 2017 Appwise Ltd. All rights reserved.
//

import XCTest
@testable import JLDishwasher

class EndpointProviderTests: XCTestCase {
    
    let APIKey = "12345"
    var endpointProvider: EndpointProviding?
    
    override func setUp() {
        super.setUp()
        endpointProvider = EndpointProvider(key: APIKey)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testProductSearchURLForDishwashersWith20PageSize() {
        verifyProductSearchURL(searchTerm: "Dishwasher", pageSize: 20)
    }
    
    func testProductSearchURLForBoschWith10PageSize() {
        verifyProductSearchURL(searchTerm: "Bosch", pageSize: 10)
    }
    
    func testProductSearchURLForSamsungWith5PageSize() {
        verifyProductSearchURL(searchTerm: "Samsung", pageSize: 5)
    }
    
    func testProductSearchURLForLGWith200PageSize() {
        verifyProductSearchURL(searchTerm: "LG", pageSize: 200)
    }
    
    func verifyProductSearchURL(searchTerm: String, pageSize: Int) {
        
        guard let url = endpointProvider?.productSearchURL(query: searchTerm, pageSize: pageSize) else {
            XCTFail("URL shouldn't be nil")
            return
        }
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        XCTAssertEqual(components?.scheme, "https")
        XCTAssertEqual(components?.host, "api.johnlewis.com")
        XCTAssertEqual(components?.path, "/v1/products/search")
        
        let queryItems = components?.queryItems
        XCTAssertEqual(queryItems?.count, 3)
        
        let searchQuery = queryItems?.first
        XCTAssertEqual(searchQuery?.name, "q")
        XCTAssertEqual(searchQuery?.value, searchTerm)
        
        let keyQuery = queryItems?[1]
        XCTAssertEqual(keyQuery?.name, "key")
        XCTAssertEqual(keyQuery?.value, APIKey)
        
        let pageSizeQuery = queryItems?[2]
        XCTAssertEqual(pageSizeQuery?.name, "pageSize")
        XCTAssertEqual(pageSizeQuery?.value, String(pageSize))
    }
}
