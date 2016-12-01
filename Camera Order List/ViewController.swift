//
//  ViewController.swift
//  Camera Order List
//
//  Created by Warren Hansen on 11/30/16.
//  Copyright © 2016 Warren Hansen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var myPicker: UIPickerView!
    
    @IBOutlet weak var myLabel: UILabel!
    
    // Input catagories data into the Array:
    var equipmentArray:[[String]] = [Quantity, Catagory.allValues, Maker.allValues]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myPicker.dataSource = self
        self.myPicker.delegate = self
    }

    // Mark: - Picker delegates and controls
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3    //equipmentArray.count
    }
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return equipmentArray[component].count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return equipmentArray[component][row]
    }
    // populate the textbox
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        myLabel.text = "\(Quantity[row]) \(Catagory.allValues[row]) \(Maker.allValues[row])"
    }
    
}

