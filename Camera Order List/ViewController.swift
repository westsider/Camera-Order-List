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
    
    // Input data into the Array:
    var pickerData = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myPicker.dataSource = self
        self.myPicker.delegate = self
    }

    // Mark: - Picker delegates and controls
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    // populate the textbox
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        myLabel.text = pickerData[row]
    }
    
}

