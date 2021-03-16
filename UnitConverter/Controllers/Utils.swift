//
//  Utils.swift
//  UnitConverter
//
//  Created by user188399 on 3/15/21.
//

import Foundation

class Utils {
    
    static let defaults = UserDefaults.standard
    
    static func roundToSpecifiedDecimalPlaces(_ value: Double) -> Double {
        var numOfDecimalPlaces: Int = self.defaults.integer(forKey: "Precision")
        
        if numOfDecimalPlaces == 0 {
            numOfDecimalPlaces = 100
        }
        
        let numOfDecimalPlacesDouble: Double = Double(numOfDecimalPlaces)
        let roundedNumber = round(value * numOfDecimalPlacesDouble) / numOfDecimalPlacesDouble
        return roundedNumber
    }
    
    static func roundToSpecifiedDecimalPlaces(_ value: String?) -> String {
        return String(roundToSpecifiedDecimalPlaces(Double(value!)!))
    }
    
}
