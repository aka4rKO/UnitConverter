//
//  Temperature.swift
//  UnitConverter
//
//  Created by user188399 on 3/14/21.
//

import Foundation

class Temperature {
    var celcius: Double
    var fahrenheit: Double
    var kelvin: Double
    var historyString2DArray: [[String]]
    static let fields: [String] = ["Celcius(C)", "Fahrenheit(F)", "Kelvin(K)"]
    
    init(celcius: Double, fahrenheit: Double, kelvin: Double) {
        self.celcius = celcius
        self.fahrenheit = fahrenheit
        self.kelvin = kelvin
        self.historyString2DArray = []
    }
}
