//
//  URLRequestFactoryTests.swift
//  JLDishwasher
//
//  Created by Martin Oppetit on 04/03/2017.
//  Copyright © 2017 Appwise Ltd. All rights reserved.
//

import XCTest
@testable import JLDishwasher

let stubbedURL = URL(string: "http://example.com")

class URLRequestFactoryTests: XCTestCase {
    
    struct MockAEndpointProvider: APIProviding {
        func productSearchURL(query: String, pageSize: Int) -> URL? {
            return stubbedURL
        }
    }
    
    var requestFactory: URLRequestFactory?
    
    override func setUp() {
        super.setUp()
        requestFactory = URLRequestFactory(endpointProvider: MockAEndpointProvider())
    }
    
    func testProductSearchRequestCreatedWithExpectedURL() {
        
        guard let request = requestFactory?.productSearchRequest(searchTerm: "search", pageSize: 5) else {
            XCTFail("request shouldn't be nil")
            return
        }
        
        XCTAssertEqual(request.url, stubbedURL, "Request's URL should be the one provided by the EndpointProvider")
    }
}
