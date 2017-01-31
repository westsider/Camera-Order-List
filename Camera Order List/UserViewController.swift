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

import UIKit

class UserViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var production: UITextField!
    
    @IBOutlet weak var company: UITextField!
    
    @IBOutlet weak var citySearch: UITextField!
    
    @IBOutlet weak var activityDial: UIActivityIndicatorView!
    
    @IBOutlet weak var weatherDisplay: UITextView!
    
    let errorOne = "Please include a state or country"
    
    let errorTwo = "Please Enter a City and State or Country"
    
    var defaultUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userName.delegate = self
        self.production.delegate = self
        self.company.delegate = self
        citySearch.text = "Venice, CA"
        print("VDL: Name: \(defaultUser.name)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        userName.text = defaultUser.name
        production.text = defaultUser.production
        company.text = defaultUser.company
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
        
        print("User: \(defaultUser.name) Prod: \(defaultUser.production) CO: \(defaultUser.company)")
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
        return true
    }
    
    //  MARK: - Search Weather
    @IBAction func searchWeather(_ sender: Any) {
        weatherDisplay.text = "Launching Search..."
        
        activityDial.startAnimating()
        
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
}




