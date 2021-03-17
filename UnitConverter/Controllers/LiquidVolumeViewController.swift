//
//  VolumeViewController.swift
//  UnitConverter
//
//  Created by user188399 on 2/17/21.
//

import UIKit

enum LiquidVolumeUnits: Int {
    case ukGallon, litre, ukPint, fluidOunce, millilitre
}

class LiquidVolumeViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var ukGallonTf: UITextField!
    @IBOutlet weak var litreTf: UITextField!
    @IBOutlet weak var ukPintTf: UITextField!
    @IBOutlet weak var fluidOunceTf: UITextField!
    @IBOutlet weak var millilitreTf: UITextField!
    @IBOutlet weak var keyboardView: CustomKeyboard!
    
    var liquidVolume: LiquidVolume = LiquidVolume(ukGallon: 0.0, litre: 0.0, ukPint: 0.0, fluidOunce: 0.0, millilitre: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ukGallonTf.delegate = self
        self.litreTf.delegate = self
        self.ukPintTf.delegate = self
        self.fluidOunceTf.delegate = self
        self.millilitreTf.delegate = self
        self.keyboardView.negationBtn.isEnabled = false
        self.keyboardView.negationBtn.backgroundColor = .lightGray
        self.loadDefaultsData("LiquidVolumeHistory")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LiquidVolumeVCToHistoryVC" {
            let historyVC = segue.destination as! HistoryViewController
            historyVC.data = liquidVolume.historyString2DArray.suffix(5)
            historyVC.dataHeadings = LiquidVolume.fields
            historyVC.segmentIndex = 2
        }
    }
    
    func loadDefaultsData(_ historyKey: String) {
        self.liquidVolume.historyString2DArray = Utils.defaults.object(forKey: historyKey) as? [[String]] ?? [[String]]()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.keyboardView.activeTextField = textField
        self.keyboardView.activeTextField.inputView = UIView()
    }
    
    func emptyAllTfs() {
        self.ukGallonTf.text = ""
        self.litreTf.text = ""
        self.ukPintTf.text = ""
        self.fluidOunceTf.text = ""
        self.millilitreTf.text = ""
    }
    
    @IBAction func onTfValueChanged(_ sender: UITextField) {
        guard let textFieldValue = sender.text else { return }
        
        if let doubleTextFieldValue = Double(textFieldValue) {
            switch LiquidVolumeUnits(rawValue: sender.tag)! {
            case .ukGallon:
                self.liquidVolume.ukGallon = doubleTextFieldValue
                self.liquidVolume.litre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 4.54609)
                self.liquidVolume.ukPint = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 8)
                self.liquidVolume.fluidOunce = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 153.722)
                self.liquidVolume.millilitre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 4546.09)
                
                self.litreTf.text = "\(self.liquidVolume.litre)"
                self.ukPintTf.text = "\(self.liquidVolume.ukPint)"
                self.fluidOunceTf.text = "\(self.liquidVolume.fluidOunce)"
                self.millilitreTf.text = "\(self.liquidVolume.millilitre)"
            case .litre:
                self.liquidVolume.ukGallon = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue / 4.54609)
                self.liquidVolume.litre = doubleTextFieldValue
                self.liquidVolume.ukPint = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 1.75975)
                self.liquidVolume.fluidOunce = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 35.1951)
                self.liquidVolume.millilitre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 1000)
                
                self.ukGallonTf.text = "\(self.liquidVolume.ukGallon)"
                self.ukPintTf.text = "\(self.liquidVolume.ukPint)"
                self.fluidOunceTf.text = "\(self.liquidVolume.fluidOunce)"
                self.millilitreTf.text = "\(self.liquidVolume.millilitre)"
            case .ukPint:
                self.liquidVolume.ukGallon = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue / 8)
                self.liquidVolume.litre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue / 1.75975)
                self.liquidVolume.ukPint = doubleTextFieldValue
                self.liquidVolume.fluidOunce = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 20)
                self.liquidVolume.millilitre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 568)
                
                self.ukGallonTf.text = "\(self.liquidVolume.ukGallon)"
                self.litreTf.text = "\(self.liquidVolume.litre)"
                self.fluidOunceTf.text = "\(self.liquidVolume.fluidOunce)"
                self.millilitreTf.text = "\(self.liquidVolume.millilitre)"
            case .fluidOunce:
                self.liquidVolume.ukGallon = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue / 153.722)
                self.liquidVolume.litre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue / 35.1951)
                self.liquidVolume.ukPint = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue / 20)
                self.liquidVolume.fluidOunce = doubleTextFieldValue
                self.liquidVolume.millilitre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue * 28.4131)
                
                self.ukGallonTf.text = "\(self.liquidVolume.ukGallon)"
                self.litreTf.text = "\(self.liquidVolume.litre)"
                self.ukPintTf.text = "\(self.liquidVolume.ukPint)"
                self.millilitreTf.text = "\(self.liquidVolume.millilitre)"
            case .millilitre:
                self.liquidVolume.ukGallon = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue / 4546.09)
                self.liquidVolume.litre = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue / 1000)
                self.liquidVolume.ukPint = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue / 568)
                self.liquidVolume.fluidOunce = Utils.roundToSpecifiedDecimalPlaces(doubleTextFieldValue / 28.4131)
                self.liquidVolume.millilitre = doubleTextFieldValue
                
                self.ukGallonTf.text = "\(self.liquidVolume.ukGallon)"
                self.litreTf.text = "\(self.liquidVolume.litre)"
                self.ukPintTf.text = "\(self.liquidVolume.ukPint)"
                self.fluidOunceTf.text = "\(self.liquidVolume.fluidOunce)"
            }
        } else {
            self.emptyAllTfs()
        }
    }
    
    @IBAction func saveBtn(_ sender: UIBarButtonItem) {
        if self.ukGallonTf.text!.isEmpty {
            showToast("Cannot save empty fields!")
        } else {
            let history: [String] = [
                Utils.roundToSpecifiedDecimalPlaces(self.ukGallonTf.text),
                Utils.roundToSpecifiedDecimalPlaces(self.litreTf.text),
                Utils.roundToSpecifiedDecimalPlaces(self.ukPintTf.text),
                Utils.roundToSpecifiedDecimalPlaces(self.fluidOunceTf.text),
                Utils.roundToSpecifiedDecimalPlaces(self.millilitreTf.text)
            ]
            
            self.liquidVolume.historyString2DArray.append(history)
            Utils.defaults.set(liquidVolume.historyString2DArray, forKey: "LiquidVolumeHistory")
            showToast("Conversion saved!")
        }
    }
    
    @IBAction func historyTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "LiquidVolumeVCToHistoryVC", sender: self)
    }

}
