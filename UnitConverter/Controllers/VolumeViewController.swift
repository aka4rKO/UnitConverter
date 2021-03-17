//
//  VolumeViewController.swift
//  UnitConverter
//
//  Created by user188399 on 2/14/21.
//

import UIKit

enum VolumeUnits: Int {
    case cubicCentimetres, cubicMetres, cubicInches, cubicFeet
}

class VolumeViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var cubicCentimetreTf: UITextField!
    @IBOutlet weak var cubicMetreTf: UITextField!
    @IBOutlet weak var cubicInchTf: UITextField!
    @IBOutlet weak var cubicFeetTf: UITextField!
    @IBOutlet weak var keyboardView: CustomKeyboard!
    
    var volume: Volume = Volume(cubicCentimetres: 0.0, cubicMetres: 0.0, cubicInches: 0.0, cubicFeet: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cubicCentimetreTf.delegate = self
        self.cubicMetreTf.delegate = self
        self.cubicInchTf.delegate = self
        self.cubicFeetTf.delegate = self
        self.keyboardView.negationBtn.isEnabled = false
        self.keyboardView.negationBtn.backgroundColor = .lightGray
        self.loadDefaultsData("VolumeHistory")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "VolumeVCToHistoryVC" {
            let historyVC = segue.destination as! HistoryViewController
            historyVC.data = volume.historyString2DArray.suffix(5)
            historyVC.dataHeadings = Volume.fields
            historyVC.segmentIndex = 5
        }
    }
    
    func loadDefaultsData(_ historyKey: String) {
        self.volume.historyString2DArray = Utils.defaults.object(forKey: historyKey) as? [[String]] ?? [[String]]()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.keyboardView.activeTextField = textField
        self.keyboardView.activeTextField.inputView = UIView()
    }
    
    func emptyAllTfs() {
        self.cubicCentimetreTf.text = ""
        self.cubicMetreTf.text = ""
        self.cubicInchTf.text = ""
        self.cubicFeetTf.text = ""
    }
    
    @IBAction func onTfValueChanged(_ sender: UITextField) {
        guard let textFieldValue = sender.text else { return }
        
        if let doubleTextFieldValue = Double(textFieldValue) {
            switch VolumeUnits(rawValue: sender.tag)! {
            case .cubicCentimetres:
                self.volume.cubicCentimetres = doubleTextFieldValue
                self.volume.cubicMetres = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue / 1e+6)
                self.volume.cubicInches = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue / 16.387)
                self.volume.cubicFeet = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue / 28317)
                
                self.cubicMetreTf.text = "\(self.volume.cubicMetres)"
                self.cubicInchTf.text = "\(self.volume.cubicInches)"
                self.cubicFeetTf.text = "\(self.volume.cubicFeet)"
            case .cubicMetres:
                self.volume.cubicCentimetres = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 1e+6)
                self.volume.cubicMetres = doubleTextFieldValue
                self.volume.cubicInches = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 61024)
                self.volume.cubicFeet = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 35.315)
                
                self.cubicCentimetreTf.text = "\(self.volume.cubicCentimetres)"
                self.cubicInchTf.text = "\(self.volume.cubicInches)"
                self.cubicFeetTf.text = "\(self.volume.cubicFeet)"
            case .cubicInches:
                self.volume.cubicCentimetres = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 16.387)
                self.volume.cubicMetres = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue / 61024)
                self.volume.cubicInches = doubleTextFieldValue
                self.volume.cubicFeet = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue / 1728)
                
                self.cubicCentimetreTf.text = "\(self.volume.cubicCentimetres)"
                self.cubicMetreTf.text = "\(self.volume.cubicMetres)"
                self.cubicFeetTf.text = "\(self.volume.cubicFeet)"
            case .cubicFeet:
                self.volume.cubicCentimetres = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 28317)
                self.volume.cubicMetres = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue / 35.315)
                self.volume.cubicInches = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 1728)
                self.volume.cubicFeet = doubleTextFieldValue
                
                self.cubicCentimetreTf.text = "\(self.volume.cubicCentimetres)"
                self.cubicMetreTf.text = "\(self.volume.cubicMetres)"
                self.cubicInchTf.text = "\(self.volume.cubicInches)"
            }
        } else {
            self.emptyAllTfs()
        }
    }
    
    @IBAction func saveBtn(_ sender: UIBarButtonItem) {
        if self.cubicCentimetreTf.text!.isEmpty {
            showToast("Cannot save empty fields!")
        } else {
            let history: [String] = [
                Utils.roundToSpecifiedDecimalPlaces(self.cubicCentimetreTf.text),
                Utils.roundToSpecifiedDecimalPlaces(self.cubicMetreTf.text),
                Utils.roundToSpecifiedDecimalPlaces(self.cubicInchTf.text),
                Utils.roundToSpecifiedDecimalPlaces(self.cubicFeetTf.text)
            ]
            
            self.volume.historyString2DArray.append(history)
            Utils.defaults.set(volume.historyString2DArray, forKey: "VolumeHistory")
            showToast("Conversion saved!")
        }
    }
    
    @IBAction func historyTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "VolumeVCToHistoryVC", sender: self)
    }

}

