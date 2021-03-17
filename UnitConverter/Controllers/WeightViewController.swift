//
//  WeightViewController.swift
//  UnitConverter
//
//  Created by user188399 on 2/17/21.
//

import UIKit

enum WeightUnits: Int {
    case kilogram, gram, ounce, pound, stone, stonePoundRemainder
}

class WeightViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var kilogramTf: UITextField!
    @IBOutlet weak var gramTf: UITextField!
    @IBOutlet weak var ounceTf: UITextField!
    @IBOutlet weak var poundTf: UITextField!
    @IBOutlet weak var stoneTf: UITextField!
    @IBOutlet weak var stonePoundRemTf: UITextField!
    @IBOutlet weak var keyboardView: CustomKeyboard!
    
    var weight: Weight = Weight(kilogram: 0.0, gram: 0.0, ounce: 0.0, pound: 0.0, stone: 0.0, stonePoundRemainder: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.kilogramTf.delegate = self
        self.gramTf.delegate = self
        self.ounceTf.delegate = self
        self.poundTf.delegate = self
        self.stoneTf.delegate = self
        self.stonePoundRemTf.delegate = self
        self.keyboardView.negationBtn.isEnabled = false
        self.keyboardView.negationBtn.backgroundColor = .lightGray
        self.loadDefaultsData("WeightHistory")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WeightVCToHistoryVC" {
            let historyVC = segue.destination as! HistoryViewController
            historyVC.data = weight.historyString2DArray.suffix(5)
            historyVC.dataHeadings = Weight.fields
            historyVC.segmentIndex = 0
        }
    }
    
    func loadDefaultsData(_ historyKey: String) {
        self.weight.historyString2DArray = Utils.defaults.object(forKey: historyKey) as? [[String]] ?? [[String]]()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.keyboardView.activeTextField = textField
        self.keyboardView.activeTextField.inputView = UIView()
    }
    
    func emptyAllTfs() {
        self.kilogramTf.text = ""
        self.gramTf.text = ""
        self.ounceTf.text = ""
        self.poundTf.text = ""
        self.stoneTf.text = ""
        self.stonePoundRemTf.text = ""
    }
    
    @IBAction func onTfValueChanged(_ sender: UITextField) {
        guard let textFieldValue = sender.text else { return }
        
        if let doubleTextFieldValue = Double(textFieldValue) {
            switch WeightUnits(rawValue: sender.tag)! {
            case .kilogram:
                self.weight.kilogram = doubleTextFieldValue
                self.weight.gram = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 1000)
                self.weight.ounce = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 35.274)
                self.weight.pound = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 2.205)
                let stone = (self.weight.pound / 14).rounded(.towardZero)
                let stonePound = (self.weight.pound).truncatingRemainder(dividingBy: 14)
                self.weight.stone = Utils.roundToSpecifiedDecimalPlaces(stone)
                self.weight.stonePoundRemainder = Utils.roundToSpecifiedDecimalPlaces(stonePound)
                
                self.gramTf.text = "\(self.weight.gram)"
                self.ounceTf.text = "\(self.weight.ounce)"
                self.poundTf.text = "\(self.weight.pound)"
                self.stoneTf.text = "\(self.weight.stone)"
                self.stonePoundRemTf.text = "\(self.weight.stonePoundRemainder)"
            case .gram:
                self.weight.kilogram = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue / 1000)
                self.weight.gram = doubleTextFieldValue
                self.weight.ounce = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue / 28.35)
                self.weight.pound = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue / 454)
                let stone = (self.weight.pound / 14).rounded(.towardZero)
                let stonePound = (self.weight.pound).truncatingRemainder(dividingBy: 14)
                self.weight.stone = Utils.roundToSpecifiedDecimalPlaces(stone)
                self.weight.stonePoundRemainder = Utils.roundToSpecifiedDecimalPlaces(stonePound)
                
                self.kilogramTf.text = "\(self.weight.kilogram)"
                self.ounceTf.text = "\(self.weight.ounce)"
                self.poundTf.text = "\(self.weight.pound)"
                self.stoneTf.text = "\(self.weight.stone)"
                self.stonePoundRemTf.text = "\(self.weight.stonePoundRemainder)"
            case .ounce:
                self.weight.kilogram = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue / 35.274)
                self.weight.gram = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 28.35)
                self.weight.ounce = doubleTextFieldValue
                self.weight.pound = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue / 16)
                let stone = (self.weight.pound / 14).rounded(.towardZero)
                let stonePound = (self.weight.pound).truncatingRemainder(dividingBy: 14)
                self.weight.stone = Utils.roundToSpecifiedDecimalPlaces(stone)
                self.weight.stonePoundRemainder = Utils.roundToSpecifiedDecimalPlaces(stonePound)
                
                self.kilogramTf.text = "\(self.weight.kilogram)"
                self.gramTf.text = "\(self.weight.gram)"
                self.poundTf.text = "\(self.weight.pound)"
                self.stoneTf.text = "\(self.weight.stone)"
                self.stonePoundRemTf.text = "\(self.weight.stonePoundRemainder)"
            case .pound:
                self.weight.kilogram = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue / 2.205)
                self.weight.gram = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 454)
                self.weight.ounce = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 16)
                self.weight.pound = doubleTextFieldValue
                let stone = (self.weight.pound / 14).rounded(.towardZero)
                let stonePound = (self.weight.pound).truncatingRemainder(dividingBy: 14)
                self.weight.stone = Utils.roundToSpecifiedDecimalPlaces(stone)
                self.weight.stonePoundRemainder = Utils.roundToSpecifiedDecimalPlaces(stonePound)
                
                self.kilogramTf.text = "\(self.weight.kilogram)"
                self.gramTf.text = "\(self.weight.gram)"
                self.ounceTf.text = "\(self.weight.ounce)"
                self.stoneTf.text = "\(self.weight.stone)"
                self.stonePoundRemTf.text = "\(self.weight.stonePoundRemainder)"
            case .stone:
                self.weight.kilogram = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 6.35)
                self.weight.gram = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 6350)
                self.weight.ounce = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 224)
                self.weight.pound = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 14)
                let stonePound = (self.weight.pound).truncatingRemainder(dividingBy: 14)
                self.weight.stone = doubleTextFieldValue.rounded(.towardZero)
                self.weight.stonePoundRemainder = Utils.roundToSpecifiedDecimalPlaces(stonePound)
                
                self.kilogramTf.text = "\(self.weight.kilogram)"
                self.gramTf.text = "\(self.weight.gram)"
                self.ounceTf.text = "\(self.weight.ounce)"
                self.poundTf.text = "\(self.weight.pound)"
                self.stoneTf.text = "\(Int(self.weight.stone))"
                self.stonePoundRemTf.text = "\(self.weight.stonePoundRemainder)"
            case .stonePoundRemainder:
                self.weight.kilogram = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue / 2.205)
                self.weight.gram = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 454)
                self.weight.ounce = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 16)
                self.weight.pound = doubleTextFieldValue
                let stone = (self.weight.pound / 14).rounded(.towardZero)
                let stonePound = (self.weight.pound).truncatingRemainder(dividingBy: 14)
                self.weight.stone = Utils.roundToSpecifiedDecimalPlaces(stone)
                self.weight.stonePoundRemainder = Utils.roundToSpecifiedDecimalPlaces(stonePound)

                self.kilogramTf.text = "\(self.weight.kilogram)"
                self.gramTf.text = "\(self.weight.gram)"
                self.ounceTf.text = "\(self.weight.ounce)"
                self.poundTf.text = "\(self.weight.pound)"
                self.stoneTf.text = "\(self.weight.stone)"
                self.stonePoundRemTf.text = "\(self.weight.stonePoundRemainder)"
            }
        } else {
            self.emptyAllTfs()
        }
    }
    
    @IBAction func saveBtn(_ sender: UIBarButtonItem) {
        if self.kilogramTf.text!.isEmpty {
            showToast("Cannot save empty fields!")
        } else {
            let history: [String] = [
                Utils.roundToSpecifiedDecimalPlaces(self.kilogramTf.text),
                Utils.roundToSpecifiedDecimalPlaces(self.gramTf.text),
                Utils.roundToSpecifiedDecimalPlaces(self.ounceTf.text),
                Utils.roundToSpecifiedDecimalPlaces(self.poundTf.text),
                "\(Utils.roundToSpecifiedDecimalPlaces(self.stoneTf.text))   \(Utils.roundToSpecifiedDecimalPlaces(self.stonePoundRemTf.text))"
            ]
            
            self.weight.historyString2DArray.append(history)
            Utils.defaults.set(weight.historyString2DArray, forKey: "WeightHistory")
            showToast("Conversion saved!")
        }
    }
    
    @IBAction func historyTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "WeightVCToHistoryVC", sender: self)
    }

}
