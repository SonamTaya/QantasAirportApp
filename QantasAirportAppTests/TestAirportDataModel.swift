//
//  TestAirportDataModel.swift
//  QantasAirportAppTests
//
//  Created by sonam taya on 11/1/22.
//

import XCTest
@testable import QantasAirportApp

class TestAirportDataModel: XCTestCase {
    
    private struct ExpectedResults {
        static  let airportName = "Anaa"
        static  let location = Location.self
        static let city = City.self
        static  let country = Country.self
        static  let region = Region.self
    }
    
    private struct Location {
        static let latitude = 17.25
        static let longitude = 145.30
    }

    private struct City {
        static let timeZoneName = "Pacific/Tahiti"
    }

    private struct Country {
        static let countryName = "French Polynesia"
    }

    private struct Region {
        static let regionName = "South Pacific"
    }
    
    var sut : [Airport]?
    
    override func setUp() {
        sut = [sampleAirport]
    }
    
    override  func tearDown() {
        sut = nil
    }
    
    func testAirportResource() {
        XCTAssertEqual(sut?.first?.airportName, ExpectedResults.airportName)
        XCTAssertEqual(sut?.first?.city.timeZoneName, ExpectedResults.city.timeZoneName)
        XCTAssertEqual(sut?.first?.country.countryName, ExpectedResults.country.countryName)
        XCTAssertEqual(sut?.first?.region.regionName, ExpectedResults.region.regionName)
        XCTAssertEqual(sut?.first?.location.latitude, ExpectedResults.location.latitude)
        XCTAssertEqual(sut?.first?.location.longitude, ExpectedResults.location.longitude)
    }
    
}

