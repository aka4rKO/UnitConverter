//
//  Length.swift
//  UnitConverter
//
//  Created by user188399 on 3/16/21.
//

import Foundation

class Length {
    var metre: Double
    var kilometre: Double
    var mile: Double
    var centimetre: Double
    var millimetre: Double
    var yard: Double
    var inch: Double
    var historyString2DArray: [[String]]
    static let fields: [String] = ["Metre(m)", "Kilometre(km)", "Mile(mi)", "Centimetre(cm)", "Millimetre(mm)", "Yard(yd)", "Inch(\")"]
    
    init(metre: Double, kilometre: Double, mile: Double, centimetre: Double, millimetre: Double, yard: Double, inch: Double) {
        self.metre = metre
        self.kilometre = kilometre
        self.mile = mile
        self.centimetre = centimetre
        self.millimetre = millimetre
        self.yard = yard
        self.inch = inch
        self.historyString2DArray = []
    }
}
