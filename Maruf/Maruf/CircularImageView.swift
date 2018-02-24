//
//  CircularImageView.swift
//  Maruf
//
//  Created by Aaron Diaz on 11/17/17.
//  Copyright © 2017 BryceSulin. All rights reserved.
//

import UIKit

class CircularImageView: UIImageView {

    override func layoutSubviews() {
        
        layer.cornerRadius = self.frame.size.width / 2.0
        self.clipsToBounds = true
        
    } 
}
