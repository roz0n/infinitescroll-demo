//
//  MockAPI.swift
//  InfiniteScrollDemo
//
//  Created by Arnaldo Rozon on 1/1/21.
//

import Foundation

class MockAPI {
    
    static let shared = MockAPI()
    var isLoadingResults = false
    
    func fetchData(paginating: Bool = false, completion: @escaping ((Result<[String], Error>) -> Void)) {
        if paginating == true { self.isLoadingResults.toggle() }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            let originalData = Array.init(repeating: "", count: 50)
            let newData = Array.init(repeating: "", count: 35)
            
            completion(.success(paginating ? newData : originalData))
            
            if paginating == true { self.isLoadingResults.toggle() }
        }
    }
    
}
