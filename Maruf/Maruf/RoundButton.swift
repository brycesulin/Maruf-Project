//
//  RoundButton.swift
//  Maruf
//
//  Created by Aaron Diaz on 2/23/18.
//  Copyright © 2018 BryceSulin. All rights reserved.
//
import UIKit

@IBDesignable
class RoundButton: UIButton {
    
    @IBInspectable var roundButton: Bool = false {
        didSet {
            if roundButton {
                layer.cornerRadius = frame.height / 2
                layer.shadowRadius = 2
                layer.shadowOpacity = 0.5
                layer.shadowOffset = CGSize(width: 2, height: 2)
            }
        }
    }
    
    override func prepareForInterfaceBuilder() {
        if roundButton {
            layer.cornerRadius = frame.height / 2
        }
    }
}

