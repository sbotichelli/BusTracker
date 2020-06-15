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
    
    var onUpdateCompletion: (([VehicleUpdate], [VehicleAnnotation], [Int]) -> Void)?
    var postitonUpdateInterval: Int = 15
    
    let apiService = BusServiceImpl()
    private let timer = RepeatingTimer(timeInterval: 15)
    
    init() {
        fetchBuses()
        runTimer()
    }
    
    func runTimer() {
        timer.eventHandler = {
            self.fetchBuses()
        }
        timer.resume()
    }
    
    func stopTimer() {
        timer.eventHandler = nil
        timer.suspend()
    }
    
    private func fetchBuses() {
        apiService.getBuses(.all, completion: {
            [weak self] result in
            switch result {
            case .success(let busResponse):
                self?.countVehicleUpdates(old: self?.buses, new: busResponse)
                self?.buses = busResponse
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    /// Counts patam
    /// - Parameters:
    ///   - oldPositions: <#oldPositions description#>
    ///   - new: <#new description#>
    private func countVehicleUpdates(old oldPositions: [VehiclePosition]?, new: [VehiclePosition]) {
        let old = oldPositions == nil ? [] : oldPositions!
        
        let updates = vehicleUpdates(old: old, new: new)
        let newAnnotations = newVehicles(old: old, new: new)
        let toRemove = toRemoveIds(old: old, new: new)
        
        onUpdateCompletion?(updates, newAnnotations, toRemove)
    }
    
    /// Creates an array of data for updating existing annotations
    /// - Parameters:
    ///   - old: list of  vehicle positions from previous iteration
    ///   - new: new list of vehicle positions
    private func vehicleUpdates(old: [VehiclePosition], new: [VehiclePosition]) -> [VehicleUpdate] {
        
        let oldIds = old.map{ $0.id }
        let newIds = new.map{ $0.id }
        let commonIds = oldIds.filter{ newIds.contains($0) }
        
        let updatedPositions = new.filter{ commonIds.contains($0.id) }
        let vehicleUpdates = updatedPositions.map{ return VehicleUpdate(from: $0) }
        
        return vehicleUpdates
    }
    
    /// Creates an array of annotations for id's that didn't exist at previous iteration
    /// - Parameters:
    ///   - old: list of  vehicle positions from previous iteration
    ///   - new: new list of vehicle positions
    private func newVehicles(old: [VehiclePosition], new: [VehiclePosition]) -> [VehicleAnnotation] {
        
        let oldIds = old.map{ $0.id }
        let newIds = new.map{ $0.id }
        let createdIds = newIds.filter{ !oldIds.contains($0) }
        
        let newVehicles = new.filter{ createdIds.contains($0.id) }
        return newVehicles.map{VehicleAnnotation(from: $0)}
    }
    
    /// Returns a list of id's that should be deleted from map
    /// - Parameters:
    ///   - old: list of  vehicle positions from previous iteration
    ///   - new: new list of vehicle positions
    private func toRemoveIds(old: [VehiclePosition], new: [VehiclePosition]) -> [Int] {
        let oldIds = old.map{ $0.id }
        let newIds = new.map{ $0.id }
        return oldIds.filter{ !newIds.contains($0) }
    }
}
