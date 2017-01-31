//
//  UserViewController.swift
//  Camera Order List
//
//  Created by Warren Hansen on 12/14/16.
//  Copyright © 2016 Warren Hansen. All rights reserved.
//  fix nav title bar miissing
//  feat: segue with tap on user row
//  feat: segue back to Main with new default user
//  feat: func to dismiss keyboard on return & click away
//  feat: design weather UI
//  feat: design weather API
//  feat: integrate weather api
//  feat: integrate date picker
//  feat: add date to event object
//  fix: 2 word city returns nil

//  fix: need timout for weather api or error check in api

import UIKit

class UserViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var production: UITextField!
    
    @IBOutlet weak var company: UITextField!
    
    @IBOutlet weak var citySearch: UITextField!
    
    @IBOutlet weak var activityDial: UIActivityIndicatorView!
    
    @IBOutlet weak var weatherDisplay: UITextView!
    
    @IBOutlet weak var dateTextField: UILabel!
    
    @IBOutlet weak var dateTextInput: UITextField!
    
    let errorOne = "Please include a state or country"
    
    let errorTwo = "Please Enter a City and State or Country"
    
    var datePickerUtility = DatePickerUtility()
    
    var defaultUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userName.delegate = self
        self.production.delegate = self
        self.company.delegate = self
        self.dateTextInput.delegate = self
        citySearch.text = "San Francisco CA"
        print("VDL: Name: \(defaultUser.name)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        userName.text = defaultUser.name
        production.text = defaultUser.production
        company.text = defaultUser.company
        dateTextInput.text = defaultUser.date
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:  - Update User
    @IBAction func updateAction(_ sender: Any) {
        
        // change default text to user name
        if (userName.text?.isEmpty)! {
            print("Username Empty")
        } else {
            let name = userName.text!
            defaultUser.name = name
            print("User:  \(name)")
        }
        
        // change default text to production
        if production.text! == "default" {
            print("production Empty")
        } else {
            defaultUser.production = production.text!
        }
        
        // change default text to company
        if company.text! == "default"  {
            print("company Empty")
        } else {
            defaultUser.company = company.text!
        }
        
        // change default text to date
        if dateTextInput.text! == ""  {
            print("Date Empty")
        } else {
            defaultUser.date = dateTextInput.text!
        }
        
        // change default text to date
        if citySearch.text! == ""  {
            print("City Empty")
        } else {
            defaultUser.city = citySearch.text!
        }
        
        print("Segue from User, Updating Default User... User: \(defaultUser.name) Prod: \(defaultUser.production) CO: \(defaultUser.company) Date: \(defaultUser.date) City: \(defaultUser.city))")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userToMain" {
            let controller = segue.destination as! MainTableViewController
            controller.defaultUser = defaultUser
        }
    }
    
    // MARK: - Keyboard behavior functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userName.resignFirstResponder()
        production.resignFirstResponder()
        company.resignFirstResponder()
        dateTextInput.resignFirstResponder()
        return true
    }
    
    //  MARK: - Search Weather
    @IBAction func searchWeather(_ sender: Any) {
        weatherDisplay.text = "Launching Search..."
        
        activityDial.startAnimating()
        
        print("Text Input: \(citySearch.text)")
        print("forecastURL: \(CurrentLocation.sharedInstance.forcastURL)")
        
        let searchResult  =  CurrentLocation.sharedInstance.parseCurrentLocation(input: citySearch.text!)
        weatherDisplay.text = searchResult
        
        // if now parsing error call weather api in closure that returns a string for the UI
        if searchResult != errorOne && searchResult !=  errorTwo {
            
            GetWeather().getForecast { (result: String) in
                self.weatherDisplay.text = result
                self.activityDial.stopAnimating()
            }
            
        }  else {
            
            self.weatherDisplay.text = searchResult
            self.activityDial.stopAnimating()
            
        }
    }
    
    //  MARK: - Activate date picker view
    @IBAction func textFieldEditing(_ sender: UITextField) {
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(UserViewController.datePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
    }

    //  MARK: - format the selected Date and update vars used in weather forcast
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        dateTextInput.text = dateFormatter.string(from: sender.date)
        
        defaultUser.date = dateFormatter.string(from: sender.date)
        
    }

}




