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
        previewLbl.text = getPreviewLblValue(sliderValue: accuracySlider.value)
    }
    
    @IBAction func accuracySliderValueChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value/step) * step
        sender.value = roundedValue
        
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
