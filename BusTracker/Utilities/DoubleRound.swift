//
//  DoubleRound.swift
//  BusTracker
//
//  Created by botichelli on 6/16/20.
//  Copyright © 2020 Oleksandra Sildushkina. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
