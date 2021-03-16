//
//  LengthViewController.swift
//  UnitConverter
//
//  Created by user188399 on 2/17/21.
//

import UIKit

enum LengthUnits: Int {
    case metre, kilometre, mile, centimetre, millimetre, yard, inch
}

class LengthViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var metreTf: UITextField!
    @IBOutlet weak var kilometreTf: UITextField!
    @IBOutlet weak var mileTf: UITextField!
    @IBOutlet weak var centimetreTf: UITextField!
    @IBOutlet weak var millimetreTf: UITextField!
    @IBOutlet weak var yardTf: UITextField!
    @IBOutlet weak var inchTf: UITextField!
    @IBOutlet weak var keyboardView: CustomKeyboard!
    
    var length: Length = Length(metre: 0.0, kilometre: 0.0, mile: 0.0, centimetre: 0.0, millimetre: 0.0, yard: 0.0, inch: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.metreTf.delegate = self
        self.kilometreTf.delegate = self
        self.mileTf.delegate = self
        self.centimetreTf.delegate = self
        self.millimetreTf.delegate = self
        self.yardTf.delegate = self
        self.inchTf.delegate = self
        self.keyboardView.negationBtn.isEnabled = false
        self.keyboardView.negationBtn.backgroundColor = .lightGray
        self.loadDefaultsData("LengthHistory")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LengthVCToHistoryVC" {
            let historyVC = segue.destination as! HistoryViewController
            historyVC.data = length.historyString2DArray.suffix(5)
            historyVC.dataHeadings = Length.fields
            historyVC.segmentIndex = 3
        }
    }
    
    func loadDefaultsData(_ historyKey: String) {
        self.length.historyString2DArray = Utils.defaults.object(forKey: historyKey) as? [[String]] ?? [[String]]()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.keyboardView.activeTextField = textField
        self.keyboardView.activeTextField.inputView = UIView()
    }
    
    func emptyAllTfs() {
        self.metreTf.text = ""
        self.kilometreTf.text = ""
        self.mileTf.text = ""
        self.centimetreTf.text = ""
        self.millimetreTf.text = ""
        self.yardTf.text = ""
        self.inchTf.text = ""
    }
    
    @IBAction func onTfValueChanged(_ sender: UITextField) {
        guard let textFieldValue = sender.text else { return }
        
        if let doubleTextFieldValue = Double(textFieldValue) {
            switch LengthUnits(rawValue: sender.tag)! {
            case .metre:
                self.length.metre = doubleTextFieldValue
                self.length.kilometre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.mile = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.centimetre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.millimetre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.yard = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.inch = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                
                self.kilometreTf.text = "\(self.length.kilometre)"
                self.mileTf.text = "\(self.length.mile)"
                self.centimetreTf.text = "\(self.length.centimetre)"
                self.millimetreTf.text = "\(self.length.millimetre)"
                self.yardTf.text = "\(self.length.yard)"
                self.inchTf.text = "\(self.length.inch)"
            case .kilometre:
                self.length.metre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.kilometre = doubleTextFieldValue
                self.length.mile = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.centimetre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.millimetre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.yard = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.inch = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                
                self.metreTf.text = "\(self.length.metre)"
                self.mileTf.text = "\(self.length.mile)"
                self.centimetreTf.text = "\(self.length.centimetre)"
                self.millimetreTf.text = "\(self.length.millimetre)"
                self.yardTf.text = "\(self.length.yard)"
                self.inchTf.text = "\(self.length.inch)"
            case .mile:
                self.length.metre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.kilometre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.mile = doubleTextFieldValue
                self.length.centimetre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.millimetre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.yard = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.inch = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                
                self.metreTf.text = "\(self.length.metre)"
                self.kilometreTf.text = "\(self.length.kilometre)"
                self.centimetreTf.text = "\(self.length.centimetre)"
                self.millimetreTf.text = "\(self.length.millimetre)"
                self.yardTf.text = "\(self.length.yard)"
                self.inchTf.text = "\(self.length.inch)"
            case .centimetre:
                self.length.metre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.kilometre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.mile = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.centimetre = doubleTextFieldValue
                self.length.millimetre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.yard = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.inch = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                
                self.metreTf.text = "\(self.length.metre)"
                self.kilometreTf.text = "\(self.length.kilometre)"
                self.mileTf.text = "\(self.length.mile)"
                self.millimetreTf.text = "\(self.length.millimetre)"
                self.yardTf.text = "\(self.length.yard)"
                self.inchTf.text = "\(self.length.inch)"
            case .millimetre:
                self.length.metre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.kilometre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.mile = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.centimetre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.millimetre = doubleTextFieldValue
                self.length.yard = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.inch = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                
                self.metreTf.text = "\(self.length.metre)"
                self.kilometreTf.text = "\(self.length.kilometre)"
                self.mileTf.text = "\(self.length.mile)"
                self.centimetreTf.text = "\(self.length.centimetre)"
                self.yardTf.text = "\(self.length.yard)"
                self.inchTf.text = "\(self.length.inch)"
            case .yard:
                self.length.metre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.kilometre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.mile = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.centimetre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.millimetre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.yard = doubleTextFieldValue
                self.length.inch = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                
                self.metreTf.text = "\(self.length.metre)"
                self.kilometreTf.text = "\(self.length.kilometre)"
                self.mileTf.text = "\(self.length.mile)"
                self.centimetreTf.text = "\(self.length.centimetre)"
                self.millimetreTf.text = "\(self.length.millimetre)"
                self.inchTf.text = "\(self.length.inch)"
            case .inch:
                self.length.metre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.kilometre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.mile = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.centimetre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.millimetre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.yard = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue)
                self.length.inch = doubleTextFieldValue
                
                self.metreTf.text = "\(self.length.metre)"
                self.kilometreTf.text = "\(self.length.kilometre)"
                self.mileTf.text = "\(self.length.mile)"
                self.centimetreTf.text = "\(self.length.centimetre)"
                self.millimetreTf.text = "\(self.length.millimetre)"
                self.yardTf.text = "\(self.length.yard)"
            }
        } else {
            self.emptyAllTfs()
        }
    }
    
    @IBAction func saveBtn(_ sender: UIBarButtonItem) {
        if self.metreTf.text!.isEmpty {
            showToast("Cannot save empty fields!")
        } else {
            let history: [String] = [
                Utils.roundToSpecifiedDecimalPlaces(self.metreTf.text),
                Utils.roundToSpecifiedDecimalPlaces(self.kilometreTf.text),
                Utils.roundToSpecifiedDecimalPlaces(self.mileTf.text),
                Utils.roundToSpecifiedDecimalPlaces(self.centimetreTf.text),
                Utils.roundToSpecifiedDecimalPlaces(self.millimetreTf.text),
                Utils.roundToSpecifiedDecimalPlaces(self.yardTf.text),
                Utils.roundToSpecifiedDecimalPlaces(self.inchTf.text)
            ]
            
            self.length.historyString2DArray.append(history)
            Utils.defaults.set(length.historyString2DArray, forKey: "LengthHistory")
            showToast("Conversion saved!")
        }
    }
    
    @IBAction func historyTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "LengthVCToHistoryVC", sender: self)
    }

}
