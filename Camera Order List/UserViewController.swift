//
//  UserViewController.swift
//  Camera Order List
//
//  Created by Warren Hansen on 12/14/16.
//  Copyright © 2016 Warren Hansen. All rights reserved.
//  fix nav title bar miissing

//  segue back to Main with new default user
//  design weather UI
//  design weather API

import UIKit

class UserViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var production: UITextField!
    
    @IBOutlet weak var company: UITextField!
    
    var defaultUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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

}
