//
//  HistoryViewController.swift
//  UnitConverter
//
//  Created by user188399 on 3/12/21.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var data = [[String]]()
    var dataHeadings = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // TODO change the data
        self.data = [["0,0", "0,1", "0,2"], ["1,0", "1,1", "1,2"]]
        self.dataHeadings = ["JH", "QW", "RR"]
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
        // TODO change the data
        switch self.segmentedControl.selectedSegmentIndex {
        case 0:
            self.data = [["0,0", "0,1", "0,2"], ["1,0", "1,1", "1,2"]]
            self.dataHeadings = ["JH", "QW", "RR"]
        case 1:
            self.data = [["0,0", "0,1", "0,2"], ["1,0", "1,1", "1,2"], ["1,0", "1,1", "1,2"]]
            self.dataHeadings = ["NB", "IU", "FY"]
        case 2:
            self.data = [["0,0", "0,1", "0,2"], ["1,0", "1,1", "1,2"], ["1,0", "1,1", "1,2"], ["1,0", "1,1", "1,2"]]
            self.dataHeadings = ["AL", "HG", "TM"]
        case 3:
            self.data = [["0,0", "0,1", "0,2", "0,5"]]
            self.dataHeadings = ["UY", "CS", "LO", "II"]
        case 4:
            self.data = []
            self.dataHeadings = []
        default:
            self.data = []
            self.dataHeadings = []
        }
        
        self.tableView.reloadData()
    }

}
