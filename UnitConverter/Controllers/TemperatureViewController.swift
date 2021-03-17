//
//  TemperatureViewController.swift
//  UnitConverter
//
//  Created by user188399 on 2/16/21.
//  Some of the code in this file was taken from the following repo:
//  https://github.com/wdevon99/IOS-Unit-Convertor.git
//

import UIKit

enum TemperatureUnits: Int {
    case celcius, fahrenheit, kelvin
}

class TemperatureViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var celciusTf: UITextField!
    @IBOutlet weak var fahrenheitTf: UITextField!
    @IBOutlet weak var kelvinTf: UITextField!
    @IBOutlet weak var keyboardView: CustomKeyboard!
    
    var temperature: Temperature = Temperature(celcius: 0.0, fahrenheit: 0.0, kelvin: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.celciusTf.delegate = self
        self.fahrenheitTf.delegate = self
        self.kelvinTf.delegate = self
        self.keyboardView.negationBtn.isEnabled = true
        self.loadDefaultsData("TemparatureHistory")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TemperatureVCToHistoryVC" {
            let historyVC = segue.destination as! HistoryViewController
            historyVC.data = temperature.historyString2DArray.suffix(5)
            historyVC.dataHeadings = Temperature.fields
            historyVC.segmentIndex = 1
        }
    }
    
    func loadDefaultsData(_ historyKey: String) {
        self.temperature.historyString2DArray = Utils.defaults.object(forKey: historyKey) as? [[String]] ?? [[String]]()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.keyboardView.activeTextField = textField
        self.keyboardView.activeTextField.inputView = UIView()
    }
    
    func emptyAllTfs() {
        self.celciusTf.text = ""
        self.fahrenheitTf.text = ""
        self.kelvinTf.text = ""
    }

    @IBAction func onTfValueChanged(_ sender: UITextField) {
        guard let textFieldValue = sender.text else { return }
        
        if let doubleTextFieldValue = Double(textFieldValue) {
            switch TemperatureUnits(rawValue: sender.tag)! {
            case .celcius:
                self.temperature.celcius = doubleTextFieldValue
                self.temperature.fahrenheit = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 9/5 + 32)
                self.temperature.kelvin = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue + 273.15)
                
                self.fahrenheitTf.text = "\(self.temperature.fahrenheit)"
                self.kelvinTf.text = "\(self.temperature.kelvin)"
            case .fahrenheit:
                self.temperature.celcius = Utils.roundToSpecifiedDecimalPlaces((doubleTextFieldValue - 32) * 5/9)
                self.temperature.fahrenheit = doubleTextFieldValue
                self.temperature.kelvin = Utils.roundToSpecifiedDecimalPlaces((doubleTextFieldValue - 32) * 5/9 + 273.15)
                
                self.celciusTf.text = "\(self.temperature.celcius)"
                self.kelvinTf.text = "\(self.temperature.kelvin)"
            case .kelvin:
                self.temperature.celcius = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue - 273.15)
                self.temperature.fahrenheit = Utils.roundToSpecifiedDecimalPlaces((doubleTextFieldValue - 273.15) * 9/5 + 32)
                self.temperature.kelvin = doubleTextFieldValue
                
                self.celciusTf.text = "\(self.temperature.celcius)"
                self.fahrenheitTf.text = "\(self.temperature.fahrenheit)"
            }
        } else {
            self.emptyAllTfs()
        }
    }
    
    @IBAction func saveBtn(_ sender: UIBarButtonItem) {
        if self.celciusTf.text!.isEmpty {
            showToast("Cannot save empty fields!")
        } else {
            let history: [String] = [
                Utils.roundToSpecifiedDecimalPlaces(self.celciusTf.text),
                Utils.roundToSpecifiedDecimalPlaces(self.fahrenheitTf.text),
                Utils.roundToSpecifiedDecimalPlaces(self.kelvinTf.text)
            ]
            
            self.temperature.historyString2DArray.append(history)
            Utils.defaults.set(temperature.historyString2DArray, forKey: "TemparatureHistory")
            showToast("Conversion saved!")
        }
    }
    
    @IBAction func historyTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "TemperatureVCToHistoryVC", sender: self)
    }
    
}
