//
//  PastOrdersViewController.swift
//  Camera Order List
//
//  Created by Warren Hansen on 12/13/16.
//  Copyright © 2016 Warren Hansen. All rights reserved.
//

import UIKit

var allEvents = [Event]()   // global ubntil I design persistance in Core Data

class PastOrdersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var newEvent: Event!
    
    var tableViewTitleArray = [String]()
    
    var equipment = [String]()
    
//    var defaultUser = User(name: "Warren Hansen", production: "Nike", company: "CO3", city: "SantaMonica", date: "12 / 20 / 2016", weather: "Sunny 72", icon: UIImage(named: "manIcon")!)
    
    var image = [UIImage]()

    @IBOutlet weak var eventsTableView: UITableView!

    @IBOutlet weak var eventNameInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        
//        // only load this until allEvents are persistant then delete
//        let pastEvent00 = Event(eventName: "Daylight Order", user: defaultUser, equipment: [equipment], images: image)
//        let pastEvent01 = Event(eventName: "Tugsten Order", user: defaultUser, equipment: [equipment], images: image)
//        let pastEvent02 = Event(eventName: "TacoBell", user: defaultUser, equipment: [equipment], images: image)
//        
//        if allEvents.count == 0 {
//            allEvents.append(pastEvent00)
//            allEvents.append(pastEvent01)
//            allEvents.append(pastEvent02)
//        }
        
        // load table view name array
        for events in allEvents {
            let name =  events.eventName
            tableViewTitleArray.append(name)
        }
        
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
