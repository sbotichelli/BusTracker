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
    
    private var buses: [BusPosition] = []
    var mapCenter = CLLocationCoordinate2D(latitude: 52.22977, longitude: 21.01178)
    var mapSpan = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
    var mapRegion: MKCoordinateRegion {
            MKCoordinateRegion(center: mapCenter, span: mapSpan)
    }
    
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
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
