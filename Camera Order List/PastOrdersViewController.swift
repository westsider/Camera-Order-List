//
//  PastOrdersViewController.swift
//  Camera Order List
//
//  Created by Warren Hansen on 12/13/16.
//  Copyright © 2016 Warren Hansen. All rights reserved.
//
//  use text input to name current array
//  append event array every time we segue

import UIKit

class PastOrdersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var newEvent: Event!
    
    var allEvents = [Event]()
    
    var equipment = [String]()
    
    var defaultUser = User(name: "Warren Hansen", production: "Nike", company: "CO3", city: "SantaMonica", date: "12 / 20 / 2016", weather: "Sunny 72", icon: UIImage(named: "manIcon")!)
    
    var image = [UIImage]()
    
    var tableViewTitleArray = [String]()

    @IBOutlet weak var eventsTableView: UITableView!

    @IBOutlet weak var eventNameInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        
        let pastEvent00 = Event(eventName: "Daylight Order", user: defaultUser, equipment: [equipment], images: image)
        let pastEvent01 = Event(eventName: "Tugsten Order", user: defaultUser, equipment: [equipment], images: image)
        let pastEvent02 = Event(eventName: "TacoBell", user: defaultUser, equipment: [equipment], images: image)
        
        
        allEvents.append(pastEvent00)
        allEvents.append(pastEvent01)
        allEvents.append(pastEvent02)
        
        
        tableViewTitleArray.append(pastEvent00.eventName)
        tableViewTitleArray.append(pastEvent01.eventName)
        tableViewTitleArray.append(pastEvent02.eventName)
        
        
        print("This is the Prior Orders VC: \(newEvent.eventName)")
        
    }
    
    // MARK: Save new event to allEvents Array
    @IBAction func saveEvent(_ sender: Any) {
        
        let textInput = eventNameInput.text
        
        newEvent.eventName = textInput!
        tableViewTitleArray.insert(newEvent.eventName, at: 0)
        //tableViewTitleArray.append(newEvent.eventName)
        //allEvents.append(newEvent)
        allEvents.insert(newEvent, at: 0)
        eventsTableView.reloadData()
        
    }
    
    // MARK: Set up Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableViewTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = tableViewTitleArray[indexPath.row]
        
        return cell
    }

}
