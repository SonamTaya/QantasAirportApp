//
//  AirportDataModel.swift
//  QantasAirportApp
//
//  Created by sonam taya on 10/1/22.
//

import Foundation

struct Airport: Decodable {
    let airportName: String
    let location: Location
    let city: City
    let country: Country
    let region: Region
}


struct Location: Decodable {
    let latitude: Double
    let longitude: Double
}

struct City: Decodable {
    let timeZoneName: String
}

struct Country: Decodable {
    let countryName: String
}

struct Region: Decodable {
    let regionName: String
}

