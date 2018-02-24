//
//  EventCell.swift
//  Maruf
//
//  Created by Aaron Diaz on 11/24/17.
//  Copyright © 2017 BryceSulin. All rights reserved.
//

import UIKit
import EventKit

class EventCell: UITableViewCell {
    
    // These labels are connected to the tableview on the Events screen
    // and are called from the ViewController.swift in order to set them
    // when the JSON is parsed
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // This method is used for clicking on events to add them to user Calendar
    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated) // keep commented out not sure if need this later
    }

}
