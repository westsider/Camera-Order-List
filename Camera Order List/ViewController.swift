//
//  ViewController.swift
//  Camera Order List
//
//  Created by Warren Hansen on 11/30/16.
//  Copyright © 2016 Warren Hansen. All rights reserved.
//
//  Comp 0 = Quantity Comp 1 = Catagory Comp 2 = Maker Comp 3 - Model
//
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
//  clean filter

import UIKit


class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var myPicker: UIPickerView!
    
    @IBOutlet weak var myLabel: UILabel!
    
    // MARK - Decalare User array and Event
    var prevCatagory = 0
    
    var localPickerIndex = setPickerArray(component: 0, row: 0, lastCatagory: 0)
    
    var equipment = [String]()
    
    var defaultUser = User(name: "Warren Hansen", production: "Nike", company: "CO3", city: "SantaMonica", date: "12 / 20 / 2016", weather: "Sunny 72")
    
    var thisEvent: Event!   //  ? = nil
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myPicker.dataSource = self
        self.myPicker.delegate = self
        
        thisEvent = Event(user: defaultUser, equipment: [equipment])
        print("Add instance of Event:")
        print((thisEvent.user.name) + " " + (thisEvent.user.production))
      
    }

    // MARK: - Picker delegates and controls
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
        
        //  dont reload localPickerIndex when component 3 move
        dontReloadOnComp3(component: component, row: row, lastCatagory: prevCatagory)
        
        reloadComponentsAndText(component: component, row: row)
        
        // zero the picker wheels when Cztagory changes
        zeroThePicker(component: component, row: row)
        
        // fill the equipoment array and text field from picker choices
        populateEquipmentArray(component: component, row: row)
    }
    
    // create an array of equipment from picker
    func populateEquipmentArray(component: Int, row: Int) {
        let comp0 = localPickerIndex[0][myPicker.selectedRow(inComponent: 0)]
        let comp1 = localPickerIndex[1][myPicker.selectedRow(inComponent: 1)]
        let comp2 = localPickerIndex[2][myPicker.selectedRow(inComponent: 2)]
        let comp3 = localPickerIndex[3][myPicker.selectedRow(inComponent: 3)]
        equipment = [comp0, comp1, comp2, comp3]
        
        var equipString: String = ""
        
        for item in equipment {
            equipString += item
            equipString +=  " "
        }
        
        myLabel.text = equipString
    }
    
    @IBAction func addEquipmentAction(_ sender: Any) {
    
        self.thisEvent.equipment.append(equipment)
        print("Added Equipment to Event:")
        print((thisEvent.user.name) + " " + (thisEvent.user.production))
        print(thisEvent.equipment)
    }
    
    
    // MARK: - Picker Convience Functions
    
    // MARK: - call a reload on text in picker UI  depending on the component switched
    func reloadComponentsAndText(component: Int, row: Int) {
        
        switch component {  // reload only the next picker when prior wheel moves
        case 0:
            break //  dont reload
        case 1:
            myPicker.reloadComponent(2)
            myPicker.reloadComponent(3)
        case 2:
            myPicker.reloadComponent(3)
        case 3:
            break    //  dont reload
        default:
            break
        }
    }
    
    //  dont reload index when component 3 moves
    func dontReloadOnComp3(component: Int, row: Int, lastCatagory: Int) {
        if component != 3 {     // dont reload index when comp 3 moves
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

