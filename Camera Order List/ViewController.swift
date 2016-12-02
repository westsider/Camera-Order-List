//
//  ViewController.swift
//  Camera Order List
//
//  Created by Warren Hansen on 11/30/16.
//  Copyright © 2016 Warren Hansen. All rights reserved.
//
//  looking for swifty smart way to populate picker wheel changes

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var myPicker: UIPickerView!
    
    @IBOutlet weak var myLabel: UILabel!
    
    //var equipmentArray:[[String]] = [Quantity, Catagory.allValues, Maker.allValues]
    
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
    
    // populate the textbox
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        localPickerIndex = setPickerArray(component: component, row: row, lastCatagory: prevCatagory
        )
        print(localPickerIndex)
        reloadComponentsAndText()
        if component == 1 {
            prevCatagory = row    // for next time setPickerArray is called
        }
        
       // myLabel.text = "\(Quantity[row]) \(Catagory.allValues[row]) \(Maker.allValues[row])"
    }
    
    // MARK: - call a reload on text in picker UI   savedCompZero
    func reloadComponentsAndText() {
       // print("\(savedCompZero)    \(savedCompOne)    \(savedCompTwo)")
        
       // myLabel.text.text = "\(localPickerIndex[0][savedCompZero]) \(localPickerIndex[1][savedCompOne])  \(localPickerIndex[2][savedCompTwo])"
        //textDisplay.adjustsFontSizeToFitWidth = true // adjust width of selection
        
        myPicker.reloadComponent(0)
        myPicker.reloadComponent(1)
        myPicker.reloadComponent(2)
        myPicker.reloadComponent(3)
    }
}

