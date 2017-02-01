//
//  lensTableViewCell.swift
//  Camera Order List
//
//  Created by Warren Hansen on 1/31/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import UIKit

class lensTableViewCell: UITableViewCell {

    @IBOutlet weak var lensLabel: UILabel!
    
    @IBOutlet weak var lensSwitch: UISwitch!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func switchValueChanged(_ sender: Any) {
//        lensSwitch.tag = 20000
//        lensSwitch.addTarget(self, action: Selector(("SwitchTriggered")), for: UIControlEvents.valueChanged)
//        
//        print("Switch Changed: \(sender)")
    }
}
