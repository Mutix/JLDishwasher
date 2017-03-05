//
//  ProductFetcherTests.swift
//  JLDishwasher
//
//  Created by Martin Oppetit on 04/03/2017.
//  Copyright © 2017 Appwise Ltd. All rights reserved.
//

import XCTest
@testable import JLDishwasher

class ProductFetcherTests: XCTestCase {
    
    func testCompletesWithErrorGivenNilRequest() {
        
        let requestFactory = MockBadRequestFactory()
        let productFetcher = ProductFetcher(requestFactory: requestFactory)
        
        let expectation = self.expectation(description: "Bad request")
        
        productFetcher.fetchProductData(searchTerm: "test", pageSize: 1) { (data, error) in
            XCTAssertNil(data, "Data should be nil")
            XCTAssertEqual(error, .invalidRequest)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testCreatesDataTaskWithExpectedURLRequest() {
        
        let stubRequest = URLRequest(url: URL(string: "http://example.com")!)
        let requestFactory = MockGoodRequestFactory(stubbingProductSearchRequest: stubRequest)
        
        let mockURLSession = MockURLSession(stubbingDataTask: MockDataTask())
        
        let productFetcher = ProductFetcher(requestFactory: requestFactory, session: mockURLSession)
        
        let expectation = self.expectation(description: "URL request check")
        
        productFetcher.fetchProductData(searchTerm: "test", pageSize: 1) { (data, error) in
            XCTAssertEqual(mockURLSession.capturedDataTaskRequest, stubRequest)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testCompletesWithErrorIfDataTaskFails() {
        
        let stubRequest = URLRequest(url: URL(string: "http://example.com")!)
        let requestFactory = MockGoodRequestFactory(stubbingProductSearchRequest: stubRequest)
        
        let dataTask = MockDataTask()
        dataTask.stubbedError = NSError(domain: "network error", code: -1000, userInfo: nil)
        
        let mockURLSession = MockURLSession(stubbingDataTask: dataTask)
        
        let productFetcher = ProductFetcher(requestFactory: requestFactory, session: mockURLSession)
        
        let expectation = self.expectation(description: "Failing data task")
        
        productFetcher.fetchProductData(searchTerm: "test", pageSize: 1) { (data, error) in
            XCTAssertNil(data, "Data should be nil")
            XCTAssertEqual(error, .requestFailed)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testCompletesWithDataIfDataTaskSucceeds() {
        
        let stubRequest = URLRequest(url: URL(string: "http://example.com")!)
        let requestFactory = MockGoodRequestFactory(stubbingProductSearchRequest: stubRequest)
        
        let dataTask = MockDataTask()
        let stubData = Data(base64Encoded: "data")
        dataTask.stubbedData = stubData
        
        let mockURLSession = MockURLSession(stubbingDataTask: dataTask)
        
        let productFetcher = ProductFetcher(requestFactory: requestFactory, session: mockURLSession)
        
        let expectation = self.expectation(description: "Successful data task")
        
        productFetcher.fetchProductData(searchTerm: "test", pageSize: 1) { (data, error) in
            XCTAssertNil(error, "Error should be nil")
            XCTAssertEqual(data, stubData)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}


// MARK: Network Test Helpers

class MockURLSession: URLSession {
    
    var capturedDataTaskRequest: URLRequest?
    var stubbedDataTask: MockDataTask
    
    init(stubbingDataTask dataTask: MockDataTask) {
        stubbedDataTask = dataTask
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        capturedDataTaskRequest = request
        stubbedDataTask.completion = completionHandler
        return stubbedDataTask
    }
}

typealias DataTaskCompletion = (Data?, URLResponse?, Error?) -> Void

class MockDataTask: URLSessionDataTask {
    
    var stubbedData: Data?
    var stubbedResponse: URLResponse?
    var stubbedError: Error?
    var completion: DataTaskCompletion?
    
    override func resume() {
        completion?(stubbedData, stubbedResponse, stubbedError)
    }
}


// MARK: Mock URL Request Factories

struct MockBadRequestFactory: URLRequestProviding {
    
    func generateProductSearchRequest(searchTerm: String, pageSize: Int) -> URLRequest? {
        return nil
    }
}

struct MockGoodRequestFactory: URLRequestProviding {
    
    var request: URLRequest?
    
    init(stubbingProductSearchRequest request: URLRequest) {
        self.request = request
    }
    
    func generateProductSearchRequest(searchTerm: String, pageSize: Int) -> URLRequest? {
        return request
    }
}

