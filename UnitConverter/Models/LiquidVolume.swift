//
//  Volume.swift
//  UnitConverter
//
//  Created by user188399 on 3/16/21.
//

import Foundation

class LiquidVolume {
    var ukGallon: Double
    var litre: Double
    var ukPint: Double
    var fluidOunce: Double
    var millilitre: Double
    var historyString2DArray: [[String]]
    static let fields: [String] = ["UK gallon(imp gal)", "Litre(L)", "UK pint(pt)", "Fluid ounce(fl oz)", "Millilitre(ml)"]
    
    init(ukGallon: Double, litre: Double, ukPint: Double, fluidOunce: Double, millilitre: Double) {
        self.ukGallon = ukGallon
        self.litre = litre
        self.ukPint = ukPint
        self.fluidOunce = fluidOunce
        self.millilitre = millilitre
        self.historyString2DArray = []
    }
}

