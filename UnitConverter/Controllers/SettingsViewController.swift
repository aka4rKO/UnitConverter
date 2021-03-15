//
//  SettingsViewController.swift
//  UnitConverter
//
//  Created by user188399 on 3/12/21.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var accuracySlider: UISlider!
    @IBOutlet weak var previewLbl: UILabel!
    let step: Float = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let numOfDecimalPlaces: Int = Utils.defaults.integer(forKey: "Precision")
        
        if numOfDecimalPlaces == 1000 {
            accuracySlider.value = 3
        } else if numOfDecimalPlaces == 10000 {
            accuracySlider.value = 4
        } else {
            accuracySlider.value = 2
        }
        
        previewLbl.text = getPreviewLblValue(sliderValue: accuracySlider.value)
    }
    
    @IBAction func accuracySliderValueChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        
        if roundedValue == 3.0 {
            Utils.defaults.set(1000, forKey: "Precision")
        } else if roundedValue == 4.0 {
            Utils.defaults.set(10000, forKey: "Precision")
        } else {
            Utils.defaults.set(100, forKey: "Precision")
        }
        
        previewLbl.text = getPreviewLblValue(sliderValue: roundedValue)
    }
    
    func getPreviewLblValue(sliderValue: Float) -> String {
        if sliderValue == 2 {
            return "12.34"
        } else if sliderValue == 3 {
            return "12.345"
        } else if sliderValue == 4 {
            return "12.3456"
        }
        
        return ""
    }

}
