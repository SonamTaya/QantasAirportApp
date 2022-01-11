//
//  TestValidAPICallReturns.swift
//  QantasAirportAppTests
//
//  Created by sonam taya on 10/1/22.
//

import XCTest

class TestValidAPICallReturns: XCTestCase {

    // System Under Test
    var sut: URLSession!
    
    override func setUp() {
      super.setUp()
      sut = URLSession(configuration: .default)
    }
    
    override func tearDown() {
      sut = nil
      super.tearDown()
    }
    
    // MARK: - Tests: API Call

    func testValidCallReturnsCompletion() {
        let url = URL(string: "https://api.qantas.com/flight/refData/airport")
        let promise = expectation(description: "Returns completion handler")
        
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = sut.dataTask(with: url!) { (data, response, error) in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    

}
