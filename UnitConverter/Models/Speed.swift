//
//  Speed.swift
//  UnitConverter
//
//  Created by user188399 on 3/16/21.
//

import Foundation

class Speed {
    var metresPerSecond: Double
    var kilometresPerHour: Double
    var milesPerHour: Double
    var nauticalMilesPerHour: Double
    var historyString2DArray: [[String]]
    static let fields: [String] = ["Metres/Second(m/s)", "Kilometres/Hour(km/h)", "Miles/Hour(mi/h)", "Nautical miles/Hour(kt/h)"]
    
    init(metresPerSecond: Double, kilometresPerHour: Double, milesPerHour: Double, nauticalMilesPerHour: Double) {
        self.metresPerSecond = metresPerSecond
        self.kilometresPerHour = kilometresPerHour
        self.milesPerHour = milesPerHour
        self.nauticalMilesPerHour = nauticalMilesPerHour
        self.historyString2DArray = []
    }
}
