//
//  WeatherStruct.swift
//  AirportGuide
//
//  Created by Ubair Nasir on 12/8/20.
//

import SwiftUI

struct WeatherStruct: Hashable, Codable, Identifiable {
    var id: UUID
    var timezone: String
    var ob_time: String
    var country_code: String
    var clouds: Int // percentage coverage
    var wind_spd: Double // miles per sec
    var app_temp: Double // feels like
    var temp: Double
    var state_code: String
    var icon: String
    var description: String
    var city_name: String
    var sunrise: String
    var sunset: String
    var lat: String
    var lon: String
    var pod: String
}
