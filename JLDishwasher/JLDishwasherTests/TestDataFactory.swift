//
//  TestDataFactory.swift
//  JLDishwasher
//
//  Created by Martin Oppetit on 04/03/2017.
//  Copyright © 2017 Appwise Ltd. All rights reserved.
//

import Foundation

class TestDataFactory {
    
    static func generateProductSearchResultsStubData() -> Data? {
        let testBundle = Bundle(for: TestDataFactory.self)
        guard let filePath = testBundle.path(forResource: "stub_product_search_results", ofType: "json") else {
            return nil
        }
        return (try? Data(contentsOf: URL(fileURLWithPath: filePath)))
    }
}
