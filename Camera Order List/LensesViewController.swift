//
//  LensesViewController.swift
//  Camera Order List
//
//  Created by Warren Hansen on 1/31/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//
//  task: Add Tableview with switches
//  task: create lens objects for each prime lens
//  task: populate tableview with lenses
//  task: activate switched to modify order

//  task: add segue to lens selection
//  task: add button / segue back to main
//  task: update the default user./ equipment order object


import UIKit

class LensesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var lensTableView: UITableView!
    
    let cellIdentifier = "lensTableViewCell"
    
    var lensKitArray =  ["1","2","3","4","5","6","7","8","9","10"]
    
    var originalArray = [String]()
    
    var lensKitArrayEdited = [String]()
    
    //var removeArrayPosition = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "L E N S  O R D E R"
        self.lensTableView.dataSource = self
        self.lensTableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        originalArray = lensKitArray
        lensKitArrayEdited = lensKitArray
    }
    
    @IBAction func updateAction(_ sender: Any) {
        
        performSegue(withIdentifier: "lensesToMain", sender: self)
        
        // pass back lensKitArrayEdited to lensKIT
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "lensesToMain" {
            let controller = segue.destination as! MainTableViewController
            // update lens kit
            controller.lenskit = lensKitArrayEdited
            //  update Event
            thisEvent.addEquipment(comp2: thisCompState[1], equip: equipment)
            // update table view array
            tableViewArray = thisEvent.populateTableview(catagory: thisCompState[1])
            print("Segue with new lens kit to Main VC")
        }
    }

    // MARK: - Set up tableview  lensesToMain
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return lensKitArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! lensTableViewCell
        cell.lensLabel?.text = lensKitArray[indexPath.row]
        // Send switch state and indexpath ro to this func?
        cell.lensSwitch.tag = indexPath.row
        cell.lensSwitch.restorationIdentifier = lensKitArray[indexPath.row]
        cell.lensSwitch.addTarget(self, action: #selector(switchTriggered(sender:)), for: UIControlEvents.valueChanged)
        return cell
    }
    
    func switchTriggered(sender: UISwitch) {
        
        let index = sender.tag
        let content = sender.restorationIdentifier!
        
        print("Lens Switch Index: \(index) For: \(content) Is On: \(sender.isOn)")
        print("originalArray Size Is: \(originalArray.count) lensKitArray Size Is: \(lensKitArray.count)")

        // remove  element from Edited Array
        if sender.isOn != true {
            lensKitArrayEdited.remove(at: index)
            print("lensKitArrayEdited Removed \(lensKitArrayEdited)")
        }
        
        // insert element to array
        if sender.isOn {
            lensKitArrayEdited.insert(content, at: index)
            print("lensKitArrayEdited Added \(lensKitArrayEdited)")
        }
        
    }


}
