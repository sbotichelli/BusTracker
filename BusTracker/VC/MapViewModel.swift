//
//  MapViewModel.swift
//  BusTracker
//
//  Created by botichelli on 6/11/20.
//  Copyright © 2020 Oleksandra Sildushkina. All rights reserved.
//

import Foundation
import MapKit

class MapViewModel {
    
    private var buses: [VehiclePosition] = []
    var mapCenter = CLLocationCoordinate2D(latitude: 52.22977, longitude: 21.01178)
    var mapSpan = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
    var mapRegion: MKCoordinateRegion {
            MKCoordinateRegion(center: mapCenter, span: mapSpan)
    }
    var vehicleAnnotations: [VehicleAnnotation] {
        return buses.map{VehicleAnnotation(from: $0)}
    }
    var onUpdateCompletion: (([VehicleAnnotation]) -> Void)?
    
    let apiService = BusServiceImpl()
    
    init() {
        fetchBuses()
    }
    
    func fetchBuses() {
        apiService.getBuses(.all, completion: {
            [weak self] result in
            switch result {
            case .success(let busResponse):
                self?.buses = busResponse
                self?.notifyViewController()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    private func notifyViewController() {
        self.onUpdateCompletion?(vehicleAnnotations)
    }
}
