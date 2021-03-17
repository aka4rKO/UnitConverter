//
//  Weight.swift
//  UnitConverter
//
//  Created by user188399 on 3/16/21.
//

import Foundation

class Weight {
    var kilogram: Double
    var gram: Double
    var ounce: Double
    var pound: Double
    var stone: Double
    var stonePoundRemainder: Double
    var historyString2DArray: [[String]]
    static let fields: [String] = ["Kilogram(kg)", "Gram(g)", "Ounce(oz)", "Pound(lb)", "Stone(st) Pound(lb)"]
    
    init(kilogram: Double, gram: Double, ounce: Double, pound: Double, stone: Double, stonePoundRemainder: Double) {
        self.kilogram = kilogram
        self.gram = gram
        self.ounce = ounce
        self.pound = pound
        self.stone = stone
        self.stonePoundRemainder = stonePoundRemainder
        self.historyString2DArray = []
    }
}

