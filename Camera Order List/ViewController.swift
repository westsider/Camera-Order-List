//
//  ViewController.swift
//  Camera Order List
//
//  Created by Warren Hansen on 11/30/16.
//  Copyright © 2016 Warren Hansen. All rights reserved.
//
//  looking for swifty smart way to populate picker wheel changes
//  todo - reset wheel 2 to o, when wheel 1 moves
//  populate text box
//  populate an event when wheel elements selected by add

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
    
    // MARK: -  populate the textbox
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        localPickerIndex = setPickerArray(component: component, row: row, lastCatagory: prevCatagory)
        
        print(localPickerIndex)
        
        reloadComponentsAndText(component: component, row: row)
        
        if component == 1 {
            prevCatagory = row    // for next time setPickerArray is called
        }
        
    }
    
    // MARK: - call a reload on text in picker UI  depending on the component switched
    func reloadComponentsAndText(component: Int, row: Int) {
        
        // out of index error when called
        // myLabel.text = "\(localPickerIndex[0][row]) \(localPickerIndex[1][row])  \(localPickerIndex[2][row])"
        
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

