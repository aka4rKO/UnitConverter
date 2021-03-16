//
//  SpeedViewController.swift
//  UnitConverter
//
//  Created by user188399 on 2/17/21.
//

import UIKit

enum SpeedUnits: Int {
    case metresPerSecond, kilometresPerHour, milesPerHour, nauticalMilesPerHour
}

class SpeedViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var metresPerSecTf: UITextField!
    @IBOutlet weak var kMetresPerHourTf: UITextField!
    @IBOutlet weak var milesPerHourTf: UITextField!
    @IBOutlet weak var nMilesPerHourTf: UITextField!
    @IBOutlet weak var keyboardView: CustomKeyboard!
    
    var speed: Speed = Speed(metresPerSecond: 0.0, kilometresPerHour: 0.0, milesPerHour: 0.0, nauticalMilesPerHour: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.metresPerSecTf.delegate = self
        self.kMetresPerHourTf.delegate = self
        self.milesPerHourTf.delegate = self
        self.nMilesPerHourTf.delegate = self
        self.keyboardView.negationBtn.isEnabled = false
        self.keyboardView.negationBtn.backgroundColor = .lightGray
        self.loadDefaultsData("SpeedHistory")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SpeedVCToHistoryVC" {
            let historyVC = segue.destination as! HistoryViewController
            historyVC.data = speed.historyString2DArray.suffix(5)
            historyVC.dataHeadings = Speed.fields
            historyVC.segmentIndex = 4
        }
    }
    
    func loadDefaultsData(_ historyKey: String) {
        self.speed.historyString2DArray = Utils.defaults.object(forKey: historyKey) as? [[String]] ?? [[String]]()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.keyboardView.activeTextField = textField
        self.keyboardView.activeTextField.inputView = UIView()
    }
    
    func emptyAllTfs() {
        self.metresPerSecTf.text = ""
        self.kMetresPerHourTf.text = ""
        self.milesPerHourTf.text = ""
        self.nMilesPerHourTf.text = ""
    }
    
    @IBAction func onTfValueChanged(_ sender: UITextField) {
        guard let textFieldValue = sender.text else { return }
        
        if let doubleTextFieldValue = Double(textFieldValue) {
            switch SpeedUnits(rawValue: sender.tag)! {
            case .metresPerSecond:
                self.speed.metresPerSecond = doubleTextFieldValue
                self.speed.kilometresPerHour = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 3.6)
                self.speed.milesPerHour = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 2.237)
                self.speed.nauticalMilesPerHour = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 1.944)
                
                self.kMetresPerHourTf.text = "\(self.speed.kilometresPerHour)"
                self.milesPerHourTf.text = "\(self.speed.milesPerHour)"
                self.nMilesPerHourTf.text = "\(self.speed.nauticalMilesPerHour)"
            case .kilometresPerHour:
                self.speed.metresPerSecond = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue / 3.6)
                self.speed.kilometresPerHour = doubleTextFieldValue
                self.speed.milesPerHour = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue / 1.609)
                self.speed.nauticalMilesPerHour = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue / 1.852)
                
                self.metresPerSecTf.text = "\(self.speed.metresPerSecond)"
                self.milesPerHourTf.text = "\(self.speed.milesPerHour)"
                self.nMilesPerHourTf.text = "\(self.speed.nauticalMilesPerHour)"
            case .milesPerHour:
                self.speed.metresPerSecond = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue / 2.237)
                self.speed.kilometresPerHour = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 1.609)
                self.speed.milesPerHour = doubleTextFieldValue
                self.speed.nauticalMilesPerHour = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue / 1.151)
                
                self.metresPerSecTf.text = "\(self.speed.metresPerSecond)"
                self.kMetresPerHourTf.text = "\(self.speed.kilometresPerHour)"
                self.nMilesPerHourTf.text = "\(self.speed.nauticalMilesPerHour)"
            case .nauticalMilesPerHour:
                self.speed.metresPerSecond = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue / 1.944)
                self.speed.kilometresPerHour = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 1.852)
                self.speed.milesPerHour = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 1.151)
                self.speed.nauticalMilesPerHour = doubleTextFieldValue
                
                self.metresPerSecTf.text = "\(self.speed.metresPerSecond)"
                self.kMetresPerHourTf.text = "\(self.speed.kilometresPerHour)"
                self.milesPerHourTf.text = "\(self.speed.milesPerHour)"
            }
        } else {
            self.emptyAllTfs()
        }
    }
    
    @IBAction func saveBtn(_ sender: UIBarButtonItem) {
        if self.metresPerSecTf.text!.isEmpty {
            showToast("Cannot save empty fields!")
        } else {
            let history: [String] = [
                Utils.roundToSpecifiedDecimalPlaces(self.metresPerSecTf.text),
                Utils.roundToSpecifiedDecimalPlaces(self.kMetresPerHourTf.text),
                Utils.roundToSpecifiedDecimalPlaces(self.milesPerHourTf.text),
                Utils.roundToSpecifiedDecimalPlaces(self.nMilesPerHourTf.text)
            ]
            
            self.speed.historyString2DArray.append(history)
            Utils.defaults.set(speed.historyString2DArray, forKey: "SpeedHistory")
            showToast("Conversion saved!")
        }
    }
    
    @IBAction func historyTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "SpeedVCToHistoryVC", sender: self)
    }

}
