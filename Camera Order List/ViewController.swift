//
//  ViewController.swift
//  Camera Order List
//
//  Created by Warren Hansen on 11/30/16.
//  Copyright © 2016 Warren Hansen. All rights reserved.
//
//  Comp 0 = Quantity Comp 1 = Catagory Comp 2 = Maker Comp 3 - Model
//  looking for swifty smart way to populate picker wheel changes
//  fix - reset wheel 2 to 0, when wheel 1 moves
//  FIX: - error when comp 3 moves wrong model on comp 3
//  populate text box
//  create an equipment object
//  populate an event equipment with wheel elements selected by add IBFunction
//  clean up picker func
//  populate text field and array
//  Fixed Event object
//  find wheel 1 causes equip array to default to arri alexa
//  add equipment array to thisEvent.Equipment
//  add tableview
//  trouble adding tableview to playgroung... moving on
//  add func to EVENT to populate tableview
//  this causes oout of index error if i dobt move the picker first
//  fill the equipoment array and text field from picker choices
//  populateEquipmentArray(component: component, row: row)
//  tableview not populating the araray - check size with print statement
//  im not setting upi the tableview correctly... I want to add the user in view did load, then populate the tableview
//  How populate tableViewArray on load before addEquipmenAction ?? ViewWillLoad(){
//  TableViewArray == event.user.name +        user.event.production }
//  use print statements to populate text in tableviewe till you get it right
//  // bool check for data in equipment -- not sure this is necessarry now
//  let isIndexValid = equipment.indices.contains(1)

//  macros not populating array or tableview
//  add func to EVENT topopulate mail message
//  add thisEvent.User and thisEvent.Equipment to tableView
//  smaller pickerwheel text - or fit to size
//  change name of tableview to mainTableview

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myPicker: UIPickerView!
    
    @IBOutlet weak var myTableView: UITableView!
    
    // MARK - Decalare User array and Event
    var prevCatagory = 0
    
    var localPickerIndex = setPickerArray(component: 0, row: 0, lastCatagory: 0)
    
    var equipment = [String]()
    
    var defaultUser = User(name: "Warren Hansen", production: "Nike", company: "CO3", city: "SantaMonica", date: "12 / 20 / 2016", weather: "Sunny 72")
    
    var thisEvent: Event!   //  ? = nil until View Did Load
    
    var tableViewArray = [[String]]()
    
    // MARK: - Lifecycle Functions  --------------------------------------------------------------------------------
    override func viewWillAppear(_ animated: Bool) {
        //  populate Event before view appears
        thisEvent = Event(user: defaultUser, equipment: [equipment])
        
        // populate eaquipment and tableView array before view appears
        populateEquipmentArray(component: 0, row: 0)
        
        // populate tabbleViewArray with User
        tableViewArray = thisEvent.populateTableview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myPicker.dataSource = self
        self.myPicker.delegate = self
    }

    // MARK: - Set up Picker    -----------------------------------------------------------------------
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4    //equipmentArray.count
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return localPickerIndex[component].count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return localPickerIndex[component][row]
    }
    
    // MARK: - when picker wheels move change the pickerArray and reload
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //  dont reload localPickerIndex when component 0 or 3 move
        dontReloadOnComp1or3(component: component, row: row, lastCatagory: prevCatagory)
        
        reloadComponentsAndText(component: component, row: row)
        
        // zero the picker wheels when Catagory changes
        zeroThePicker(component: component, row: row)

        // fill the equipoment array and text field from picker choices
        populateEquipmentArray(component: component, row: row)
    }
    
    // MARK: Set up Table View  ---------------------------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return thisEvent.tableViewSize(tableViewArray: tableViewArray)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        print("This is the array for tableView: \(tableViewArray)\n")
        cell.textLabel?.text = tableViewArray[0][indexPath.row]
        cell.detailTextLabel?.text = tableViewArray[1][indexPath.row]
        
        return cell
    }
    
    // MARK: - TableView Convience Functions    -----------------------------------------------------------------------
    // create an array of equipment from picker
    func populateEquipmentArray(component: Int, row: Int) {
        
        // find which rows are selected in each component
        let comp0 = localPickerIndex[0][myPicker.selectedRow(inComponent: 0)]
        let comp1 = localPickerIndex[1][myPicker.selectedRow(inComponent: 1)]
        let comp2 = localPickerIndex[2][myPicker.selectedRow(inComponent: 2)]
        let comp3 = localPickerIndex[3][myPicker.selectedRow(inComponent: 3)]
        
         // populate the array for label verification and addition to the event
        equipment = [comp0, comp1, comp2, comp3]
    }
    
    // MARK: - Add equipment to Event and tableview
    @IBAction func addEquipmentAction(_ sender: Any) {
        
        self.thisEvent.equipment.append(equipment)
        tableViewArray = thisEvent.populateTableview()

        myTableView.reloadData()
        print("func addEquipmentAction exiting with: \(thisEvent.equipment)\n")
    }
    
    // MARK: - Picker Convience Functions ----------------------------------------------------------------
    // MARK: - call a reload on text in picker UI  depending on the component switched
    func reloadComponentsAndText(component: Int, row: Int) {
        
        switch component {  // reload only the next picker when prior wheel moves
        case 0:
            break           //  dont reload because quantity changes
        case 1:
            myPicker.reloadComponent(2)
            myPicker.reloadComponent(3)
        case 2:
            myPicker.reloadComponent(3)
        case 3:
            break           //  dont reload becuase only the model changed
        default:
            break
        }
    }
    
    //  dont reload localPickerIndex when component 0 or 3 move
    func dontReloadOnComp1or3(component: Int, row: Int, lastCatagory: Int) {
        if component == 0 {
            // only update the quantity
            localPickerIndex[0][0]  = String(myPicker.selectedRow(inComponent: 0))
        }
        
        if component == 1 || component == 2 {     //  full update on comp 1 and 2 only
            localPickerIndex = setPickerArray(component: component, row: row, lastCatagory: prevCatagory)
        }
    }
    
    // zero the picker wheels when Catagory changes
    func zeroThePicker(component: Int, row: Int){
        if component == 1 {  // with new catagory set wheel 2 and 3 safely to index 0
            myPicker.selectRow(0, inComponent: 2, animated: true)
            myPicker.selectRow(0, inComponent: 3, animated: true)
            prevCatagory = row    // if wheel 1 moves save the componennt to pass to setPickerArray
        }
    }
    
}









