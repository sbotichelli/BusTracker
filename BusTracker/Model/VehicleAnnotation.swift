//
//  VehicleAnnotation.swift
//  BusTracker
//
//  Created by botichelli on 6/12/20.
//  Copyright © 2020 Oleksandra Sildushkina. All rights reserved.
//

import Foundation
import MapKit

class VehicleAnnotation: NSObject, MKAnnotation {
    let id: Int
    dynamic var coordinate: CLLocationCoordinate2D
    let title: String?
    let vehicleType: VehicleType
    let direction: Int?

    init(from position: VehiclePosition) {
        self.id = position.id
        self.coordinate = position.coordinate()
        self.title = position.line
        self.vehicleType = position.vehicleType()
        self.direction = position.direction
    }
}
