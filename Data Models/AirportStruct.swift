//
//  AirportStruct.swift
//  AirportGuide
//
//  Created by Ubair Nasir on 12/1/20.
//

import SwiftUI
import Foundation


struct AirportStruct: Decodable {
    //public var id: UUID
    //var airport_code: String
    var name: String
    var city: String
    var state: String
    var country: String
    var elevation: Double
    var lat: Double
    var lon: Double
    var tz: String
   
}
/*
 "00AK": {
     "icao": "00AK",
     "iata": "",
     "name": "Lowell Field",
     "city": "Anchor Point",
     "state": "Alaska",
     "country": "US",
     "elevation": 450,
     "lat": 59.94919968,
     "lon": -151.695999146,
     "tz": "America\/Anchorage"
 }
 */

