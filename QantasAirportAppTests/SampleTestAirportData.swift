//
//  SampleTestAirportData.swift
//  QantasAirportAppTests
//
//  Created by sonam taya on 11/1/22.
//

import XCTest
@testable import QantasAirportApp

var sampleAirport: Airport{
  load("airport")
}

func load<T: Decodable>(_ testFile: String) -> T {
    let bundle = Bundle(identifier: "com.qanta.QantasAirportAppTests")
    guard let dataFile = bundle?.url(forResource: testFile, withExtension: "json") else {
        fatalError("Failed to load test data \(testFile)")
    }
    do {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let data = try Data(contentsOf: dataFile)
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Failed to parse the sample data \(error.localizedDescription)")
    }
}

