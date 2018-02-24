//
//  EventCellTableViewCell.swift
//  Maruf
//
//  Created by Aaron Diaz on 11/16/17.
//  Copyright © 2017 BryceSulin. All rights reserved.
//

import UIKit

class EventCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var dateTag: UILabel!
    @IBOutlet weak var titleTag: UILabel!
    @IBOutlet weak var descTag: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
