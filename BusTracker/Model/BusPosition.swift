//
//  BusResponse.swift
//  BusTracker
//
//  Created by botichelli on 6/11/20.
//  Copyright © 2020 Oleksandra Sildushkina. All rights reserved.
//

import Foundation
import MapKit

struct BusPosition: Codable {
    let id: Int
    let type: String
    let direction: Int?
    let line: String
    let lat: Double
    let lon: Double
    
    func coordinate() -> CLLocation {
        return CLLocation(latitude: lat, longitude: lon)
    }
    
    func vehicleType() -> VehicleType {
        return VehicleType(rawValue: type) ?? VehicleType.bus
    }
    
}
