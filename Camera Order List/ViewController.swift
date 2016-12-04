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

//  create an event object
//  populate an event object when wheel elements selected by add

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var myPicker: UIPickerView!
    
    @IBOutlet weak var myLabel: UILabel!
    
    var prevCatagory = 0
    
    var localPickerIndex = setPickerArray(component: 0, row: 0, lastCatagory: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myPicker.dataSource = self
        self.myPicker.delegate = self
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
    
    // MARK: - when wheels move change the array and reload
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component != 3 {     // dont reload index when comp 3 moves
           localPickerIndex = setPickerArray(component: component, row: row, lastCatagory: prevCatagory)
        }
        
        
        reloadComponentsAndText(component: component, row: row)
        
        if component == 1 {
            prevCatagory = row    // if wheel 1 moves save the componennt to pass to setPickerArray
            // with new catagory set wh22l 2 and 3 to index 0
            myPicker.selectRow(0, inComponent: 2, animated: true)
            myPicker.selectRow(0, inComponent: 3, animated: true)
            //myLabel.text = "\(localPickerIndex[0][row]) \(localPickerIndex[1][row])  \(localPickerIndex[2][0])"
        }
        
        // TODO: - create an event that this is stored in
        myLabel.text = "\(localPickerIndex[0][myPicker.selectedRow(inComponent: 0)]) \(localPickerIndex[1][myPicker.selectedRow(inComponent: 1)]) \(localPickerIndex[2][myPicker.selectedRow(inComponent: 2)]) \(localPickerIndex[3][myPicker.selectedRow(inComponent: 3)])"
        print(localPickerIndex[3])
        
    }
    
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
}

