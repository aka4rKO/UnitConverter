//
//  Volume.swift
//  UnitConverter
//
//  Created by user188399 on 3/17/21.
//

import Foundation

class Volume {
    var cubicCentimetres: Double
    var cubicMetres: Double
    var cubicInches: Double
    var cubicFeet: Double
    var historyString2DArray: [[String]]
    static let fields: [String] = ["Cubic centimetres(cm3)", "Cubic metres(m3)", "Cubic inches(in3)", "Cubic feet(ft3)"]
    
    init(cubicCentimetres: Double, cubicMetres: Double, cubicInches: Double, cubicFeet: Double) {
        self.cubicCentimetres = cubicCentimetres
        self.cubicMetres = cubicMetres
        self.cubicInches = cubicInches
        self.cubicFeet = cubicFeet
        self.historyString2DArray = []
    }
}
