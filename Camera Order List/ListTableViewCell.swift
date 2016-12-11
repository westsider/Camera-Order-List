//
//  ListTableViewCell.swift
//  Camera Order List
//
//  Created by Warren Hansen on 12/11/16.
//  Copyright © 2016 Warren Hansen. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var imageTableViewCell: UIImageView!
    
    @IBOutlet weak var titleTableView: UILabel!
    
    @IBOutlet weak var detailTableView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//
//    override func prepareForReuse() {
//        
//        super.prepareForReuse()
//        
//        if imageTableViewCell.image == nil {
//            //activityIndicator.startAnimating()
//            print("imageTableViewCell.image == nil")
//        }
//    }
}
