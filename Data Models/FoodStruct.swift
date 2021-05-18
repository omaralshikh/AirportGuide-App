//
//  FoodStruct.swift
//  AirportGuide
//
//  Created by Ubair Nasir on 12/2/20.
//


import SwiftUI

struct FoodStruct: Hashable, Codable, Identifiable {
    public var id: UUID
    var name: String
    var url: String
    var address: String
    var latitude: String
    var longitude: String
    var cuisines: String
    var timings: String
    //var highlights: String
    var average_cost_for_two: Double //might be an integer
    var aggregate_rating: String
    var menu_url: String // maybe UUID
    var featured_image: String
    var phone_numbers: String
}


