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
}

protocol BusService {
    func getBuses(_ requestType: BusRequestType, completion: @escaping(Result<BusResponse, Error>) -> Void)
}

class BusServiceImpl: BusService {
    
    private let path = "weather"
    private var parameters: [String : String] = [:]
    
    func getBuses(_ requestType: BusRequestType, completion: @escaping(Result<BusResponse, Error>) -> Void) {
        //TODO: make request
    }
}
