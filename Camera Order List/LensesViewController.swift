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
//  correct why navigation is incorrect
//  task: edit tableview array with new lens kit

//  bug: summicron-c reloads entire picker array
//  task: write function and object definitions
//  task: finish other lens kits
//  task: figure out why main is wiping out tableview array
//  task: add segue to lens selection
//  task: add button / segue back to main
//  task: update the default user./ equipment order object


import UIKit

class LensesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var lensTableView: UITableView!
    
    let cellIdentifier = "lensTableViewCell"
    
    var originalArray = myEquipment.lenskit
    
    var lensKitArrayEdited = myEquipment.lenskit  // was [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "L E N S  O R D E R"
        self.lensTableView.dataSource = self
        self.lensTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        youShoudSeeThis(say: "****** viewWillAppear for Lenses - tableViewArray :", see: myEquipment.tableViewArray as AnyObject)
    }
    
    //MARK: - Update the lens kit and return to main VC
    @IBAction func updateAction(_ sender: Any) {
        
        // not getting the edited lens package back
        youShoudSeeThis(say: "****** Leaving Lenses - myEquipment.equipment:", see: myEquipment.equipment as AnyObject)
        
        // update equipmet array for Main VC
        myEquipment.equipment[4] = lensKitArrayEdited.joined(separator: ", ")
        youShoudSeeThis(say: "Updated myEquipment.equipment[4] ", see: myEquipment.equipment[4] as AnyObject)
        
        // need to update tablviewarray   thisEvent.updateLensKit in myEquipment.equipment[4]
        
        // this will update the equipment but not the tableview array
        myEquipment.updateLensKit(update: lensKitArrayEdited.joined(separator: ", "))
        
        // update the tableview
        myEquipment.tableViewArray = thisEvent.populateTableview(catagory:  myEquipment.thisCompState[1] )
        
        _ = navigationController?.popToRootViewController(animated: true)
        
    }

    // MARK: - Set up tableview  lensesToMain
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // return lensKitArray.count
        return lensKitArrayEdited.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! lensTableViewCell
        cell.lensLabel?.text = lensKitArrayEdited[indexPath.row] // lensKitArray[indexPath.row]
        // Send switch state and indexpath ro to this func?
        cell.lensSwitch.tag = indexPath.row
        cell.lensSwitch.restorationIdentifier = lensKitArrayEdited[indexPath.row] // lensKitArray[indexPath.row]
        cell.lensSwitch.addTarget(self, action: #selector(switchTriggered(sender:)), for: UIControlEvents.valueChanged)
        return cell
    }
    
    /// logic to modify a lens kit from swich positions in the lens kit tableView
    func switchTriggered(sender: UISwitch) {
        
        let index = sender.tag
        let content = sender.restorationIdentifier!
        
        print("Lens Switch Index: \(index) For: \(content) Is On: \(sender.isOn)")
        
        // remove  element from Edited Array
        if sender.isOn != true {
            lensKitArrayEdited.remove(at: index)
            print("\nlensKitArrayEdited Removed \(lensKitArrayEdited)")
        }
        
        // insert element to array
        if sender.isOn {
            lensKitArrayEdited.insert(content, at: index)
            print("lensKitArrayEdited Added \(lensKitArrayEdited)")
        }
        print("\noriginalArray Size Is: \(originalArray.count) lensKitArrayEdited Size Is: \(lensKitArrayEdited.count)\n")
    }
}
