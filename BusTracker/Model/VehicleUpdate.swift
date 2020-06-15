//
//  VehicleUpdate.swift
//  BusTracker
//
//  Created by botichelli on 6/15/20.
//  Copyright © 2020 Oleksandra Sildushkina. All rights reserved.
//

import Foundation
import MapKit

struct VehicleUpdate {
    let id: Int
    let lat: Double
    let lon: Double
    let direction: Int?
    
    init(from position: VehiclePosition) {
        self.id = position.id
        self.lat = position.lat
        self.lon = position.lon
        self.direction = position.direction
    }
    
    func coordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
}
