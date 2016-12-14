//
//  PastOrdersViewController.swift
//  Camera Order List
//
//  Created by Warren Hansen on 12/13/16.
//  Copyright © 2016 Warren Hansen. All rights reserved.
//

import UIKit

class PastOrdersViewController: UIViewController {
    
    var newEvent: Event!
    
    var allEvents = [Event]()

    override func viewDidLoad() {
        super.viewDidLoad()

        print("This is the Prior Orders VC: \(newEvent.eventName)")
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        
    }

}
