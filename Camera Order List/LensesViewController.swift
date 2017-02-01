//
//  LensesViewController.swift
//  Camera Order List
//
//  Created by Warren Hansen on 1/31/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//
//  task: Add Tableview with switches
//  task: create lens objects for each prime lens

//  task: populate tableview with lenses
//  task: activate switched to modify order
//  task: add segue to lens selection
//  task: add button / segue back to main
//  task: update the default user./ equipment order object


import UIKit

class LensesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var lensTableView: UITableView!
    
    let cellIdentifier = "lensTableViewCell"
    
    let demoLensArray =  ["1","2","3","4","5","6","7","8","9","10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "L E N S  O R D E R"
        self.lensTableView.dataSource = self
        self.lensTableView.delegate = self
        
    }

    // MARK: - Set up tableview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! lensTableViewCell
        cell.lensLabel?.text = demoLensArray[indexPath.row]
        return cell
        
    }
    


}
