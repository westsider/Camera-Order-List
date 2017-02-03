//
//  MainTableViewViewController.swift
//  Camera Order List
//
//  feat: a new feature
//  fix: a bug fix
//  docs: changes to documentation
//  style: formatting, missing semi colons, etc; no code change
//  refactor: refactoring production code
//  test: adding tests, refactoring test; no production code change
//  chore: updating build tasks, package manager configs, etc; no production code change
//
//  Created by Warren Hansen on 11/30/16.
//  Copyright © 2016 Warren Hansen. All rights reserved.
//
//  Comp 0 = Quantity Comp 1 = Catagory Comp 2 = Maker Comp 3 - Model
//  looking for swifty smart way to populate picker wheel changes
//  fix - reset wheel 2 to 0, when wheel 1 vares
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
//  smaller pickerwheel text - or fit to size
//  fix: quant display turning from 2-1 causes 2 display 0 print
//  change name of tableview to MainTableView
//  feat: added icons and a ListTableViewCell
//  chore:  icons to equipment object
//  feat: added unique icons to tableview items
//  style: make icons smaller and text consistant helvetica Neu
//  feat: add eventName to Event Object in prep for adding past events VC
//  feat: create past events view contorller
//  feat: add navigation controller
//  feat: create past events array loadable in past events VC
//  manually create a pastUserArray
//  load the array into tableview
//  use text input to name current array
//  append event array ewhen new name is saved
//  feat: proved item persists bettween segues back and forth
//  feat: Production info and weather report
//  *** lens details Update UI,
//  task: sequway to lens picker and segway back
//  task edit lenses with switches and update array

//  task: update tableview on main
//  task: properly dispose old view controllers
//  *** Navigation not properly desptroying views
//  *** Core Data persistence of Important objects
//  *** Share Equipment Order
//  *** Tutorial framework of alert views that page by, leave the instruction for later date

//  **** After all of the app is working finish adding all of the equipment

import UIKit

var thisEvent: Event!   //  ? = nil until View Did Load global until core data

//var thisCompState = [Int]()

var equipment = [String]()

//  var tableViewArray = [[String]]()

var myEquipment = equipmentObject()


class MainTableViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myPicker: UIPickerView!
    
    @IBOutlet weak var myTableView: UITableView!
    
    // MARK - Decalare User array and Event
    var prevCatagory = 0

    var defaultUser = User(name: "Warren Hansen", production: "Nike", company: "CO3", city: "SantaMonica", date: "12 / 20 / 2016", weather: "Sunny 72", icon: UIImage(named: "manIcon")!)
    
    var image = [UIImage]()
    
    let cellIdentifier = "ListTableViewCell"
    
    // var lenskit = [String]()
    
    // MARK: - Lifecycle Functions
    override func viewWillAppear(_ animated: Bool) {
        //  populate Event before view appears
        thisEvent = Event(eventName: "Passed In Current", user: defaultUser, equipment: [equipment], images: image)
        thisEvent.images.append(thisEvent.user.icon)
        
        // populate eaquipment and tableView array before view appears
        populateEquipmentArray(component: 0, row: 0)
        
        // populate tabbleViewArray with User
        //tableViewArray = thisEvent.populateTableview(catagory:  myPicker.selectedRow(inComponent: 1))
        myEquipment.tableViewArray = thisEvent.populateTableview(catagory:  myPicker.selectedRow(inComponent: 1))
        
        myEquipment.setPickerArray(component: 0, row: 0, lastCatagory: 0)
        
        myTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "C A M E R A  O R D E R"
        self.myPicker.dataSource = self
        self.myPicker.delegate = self
    }
    
    
    // MARK: Save / Add Action
    @IBAction func saveAddAction(_ sender: Any) {
        
        //performSegue(withIdentifier: "MainToPastOrders", sender: self)
        
    }
    
    // MARK: - Set up Picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4    //equipmentArray.count
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return  myEquipment.pickerArray[component].count //localPickerIndex[component].count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  myEquipment.pickerArray[component][row] //localPickerIndex[component][row]
    }
    
    // MARK: - when picker wheels move change the pickerArray and reload
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //  dont reload localPickerIndex when component 0 or 3 move
        dontReloadOnComp0or3(component: component, row: row, lastCatagory: prevCatagory)
        
        reloadComponentsAndText(component: component, row: row)
        
        // zero the picker wheels when Catagory changes
        zeroThePicker(component: component, row: row)
        
        // fill the equipoment array and text field from picker choices
        populateEquipmentArray(component: component, row: row)
    }
    
    //  make picker text fill space allowed
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.black
        pickerLabel.text = myEquipment.pickerArray[component][row]  // localPickerIndex[component][row]
        pickerLabel.font = UIFont(name: "Helvetica", size: 18) // In this use your custom font
        pickerLabel.textAlignment = NSTextAlignment.center
        pickerLabel.adjustsFontSizeToFitWidth = true
        return pickerLabel
    }
    
    // MARK: Set up Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return thisEvent.tableViewSize(tableViewArray: myEquipment.tableViewArray)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ListTableViewCell
        print("This is the array for tableView: \(myEquipment.tableViewArray)\n")
        cell.imageTableViewCell.image =  thisEvent.images[indexPath.row] //image[indexPath.row]
        cell.titleTableView?.text = myEquipment.tableViewArray[0][indexPath.row]
        cell.detailTableView?.text = myEquipment.tableViewArray[1][indexPath.row]
        return cell
    }
    
    // MARK: - Segue to User VC
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            print("Row: \(indexPath.row) segue to User")
            
            performSegue(withIdentifier: "mainToUser", sender: self)
        }
    }
    
    // MARK: - TableView Convience Functions
    // create an array of equipment from picker
    func populateEquipmentArray(component: Int, row: Int) {
        
        // find which rows are selected in each component
        let comp0 = myEquipment.pickerArray[0][myPicker.selectedRow(inComponent: 0)]
        let comp1 =  myEquipment.pickerArray[1][myPicker.selectedRow(inComponent: 1)]
        let comp2 = myEquipment.pickerArray[2][myPicker.selectedRow(inComponent: 2)]
        let comp3 = myEquipment.pickerArray[3][myPicker.selectedRow(inComponent: 3)]
        // set up the picker component component state array
        myEquipment.thisCompState = [myPicker.selectedRow(inComponent: 0),myPicker.selectedRow(inComponent: 1),myPicker.selectedRow(inComponent: 2),myPicker.selectedRow(inComponent: 3)]
        // find which lens kit goes with this state
        myEquipment.lenskit = setPrimesKit(compState: myEquipment.thisCompState)// unknown kit
        print("Primes Selected: \(myEquipment.lenskit)")
        
        // populate the array for label verification and addition to the event
        equipment = [comp0, comp1, comp2, comp3, myEquipment.lenskit.joined()]
        print("Equipment array now includes lens kit: \(equipment)")
    }
    
    
    // MARK: - Add equipment to Event and tableview
    @IBAction func addEquipmentAction(_ sender: Any) {
        
        // if this is a prime lens - segue to lenses - pass lens kit array  - edit array with switches - pass lens kit aray back to main
        if myPicker.selectedRow(inComponent: 1) == 1 {
            // segue mainToLenses
            performSegue(withIdentifier: "mainToLenses", sender: self)
 
        }
        
        // else update array
        thisEvent.addEquipment(comp2: myPicker.selectedRow(inComponent: 1), equip: equipment)
        myEquipment.tableViewArray = thisEvent.populateTableview(catagory:  myPicker.selectedRow(inComponent: 1) )
        myTableView.reloadData()
        print("func addEquipmentAction exiting with: \(thisEvent.equipment)\n")
        
    }
    
    // MARK: - Picker Convience Functions
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
    func dontReloadOnComp0or3(component: Int, row: Int, lastCatagory: Int) {
        
        if component == 1 || component == 2 {     //  full update on comp 1 and 2 only
            
            myEquipment.setPickerArray(component: component, row: row, lastCatagory: prevCatagory)
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
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainToPriorOrders" {
            let controller = segue.destination as! PastOrdersViewController
            controller.newEvent = thisEvent
        }
        
        if segue.identifier == "mainToUser" {
            let controller = segue.destination as! UserViewController
            controller.defaultUser = defaultUser
            print("Segue with default user to Users VC")
        }
        
        if segue.identifier == "mainToLenses" {
            let controller = segue.destination as! LensesViewController
            controller.lensKitArray = myEquipment.lenskit
            
        }
    }
}









