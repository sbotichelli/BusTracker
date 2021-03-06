//
//  BusService.swift
//  BusTracker
//
//  Created by botichelli on 6/11/20.
//  Copyright © 2020 Oleksandra Sildushkina. All rights reserved.
//

import Foundation

enum BusRequestType {
    case all
    case region(lat: Double, lon: Double, radius: Double)
}

protocol BusService {
    func getBuses(_ requestType: BusRequestType, completion: @escaping(Result<[VehiclePosition], Error>) -> Void)
}

class BusServiceImpl: BusService {
    
    private let path = "wz/movements"
    private var parameters: [String : String] = [:]
    
    let apiServise = APIService.shared
    let decoder = JSONDecoder()
    
    func getBuses(_ requestType: BusRequestType, completion: @escaping(Result<[VehiclePosition], Error>) -> Void) {
        
        switch requestType {
        case .region(let lat, let lon, let radius):
            let requestedRadius = radius > 0.03 ? 0.03 : radius
            parameters["lat"] = String(lat.rounded(toPlaces: 4))
            parameters["lon"] = String(lon.rounded(toPlaces: 4))
            parameters["radius"] = String(requestedRadius.rounded(toPlaces: 4))
        default:
            parameters = [:]
        }
        
        apiServise.getRequestWithParameters(path: path, parameters: parameters, completion: {
            [weak self] data, error in
            if error == nil {
                guard let data = data else { return }
                
                do {
                    if let result = try
                        self?.decoder.decode([VehiclePosition].self, from: data) {
                        completion(.success(result))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(error!))
            }
        })
    }
}
