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
    let cars = ["Tesla", "Nissan", "Lambo", "Jeep"]
    let fruits = ["Banana", "Papaya", "Grapes"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return cars.count
        case 1:
            return fruits.count
        case 2:
            return cars.count
        case 3:
            return fruits.count
        case 4:
            return 0
        default:
            break
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            cell.textLabel?.text = cars[indexPath.row]
        case 1:
            cell.textLabel?.text = fruits[indexPath.row]
        case 2:
            cell.textLabel?.text = cars[indexPath.row]
        case 3:
            cell.textLabel?.text = fruits[indexPath.row]
        case 4:
            return cell
        default:
            break
        }
        
        return cell
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }

}
