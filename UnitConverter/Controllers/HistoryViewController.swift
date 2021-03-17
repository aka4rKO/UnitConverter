//
//  HistoryViewController.swift
//  UnitConverter
//
//  Created by user188399 on 3/12/21.
//

import UIKit

enum TabbarItems: Int {
    case weight, temperature, liquidVolume, length, speed, volume
}

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var data = [[String]]()
    var dataHeadings = [String]()
    var segmentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.segmentedControl.selectedSegmentIndex = self.segmentIndex
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.data.count == 0 {
            self.tableView.setEmptyMessage("No conversions are saved!")
        } else {
            self.tableView.restore()
        }
        
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = self.dataHeadings[indexPath.row]
        cell.detailTextLabel?.text = self.data[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionHeadings = [String]()
        
        for (idx, _) in self.data.enumerated() {
            sectionHeadings.append("Conversion \(idx + 1)")
        }
        
        if section < sectionHeadings.count {
            return sectionHeadings[section]
        }

        return nil
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch self.segmentedControl.selectedSegmentIndex {
        case TabbarItems.weight.rawValue:
            let history = Utils.defaults.object(forKey: "WeightHistory") as? [[String]] ?? [[String]]()
            self.data = history.suffix(5)
            self.dataHeadings = Weight.fields
        case TabbarItems.temperature.rawValue:
            let history = Utils.defaults.object(forKey: "TemparatureHistory") as? [[String]] ?? [[String]]()
            self.data = history.suffix(5)
            self.dataHeadings = Temperature.fields
        case TabbarItems.liquidVolume.rawValue:
            let history = Utils.defaults.object(forKey: "LiquidVolumeHistory") as? [[String]] ?? [[String]]()
            self.data = history.suffix(5)
            self.dataHeadings = LiquidVolume.fields
        case TabbarItems.length.rawValue:
            let history = Utils.defaults.object(forKey: "LengthHistory") as? [[String]] ?? [[String]]()
            self.data = history.suffix(5)
            self.dataHeadings = Length.fields
        case TabbarItems.speed.rawValue:
            let history = Utils.defaults.object(forKey: "SpeedHistory") as? [[String]] ?? [[String]]()
            self.data = history.suffix(5)
            self.dataHeadings = Speed.fields
        case TabbarItems.volume.rawValue:
            let history = Utils.defaults.object(forKey: "VolumeHistory") as? [[String]] ?? [[String]]()
            self.data = history.suffix(5)
            self.dataHeadings = Volume.fields
        default:
            self.data = []
            self.dataHeadings = []
        }
        
        self.tableView.reloadData()
    }

}
