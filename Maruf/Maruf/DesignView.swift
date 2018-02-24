//
//  DesignView.swift
//  Maruf
//
//  Created by Aaron Diaz on 11/24/17.
//  Copyright © 2017 BryceSulin. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class DesignView : UIView {
    @IBInspectable var cornerRadius : CGFloat = 2
    @IBInspectable var shadowColor : UIColor? = UIColor.black
    @IBInspectable let shadowOffSetWidth : Int = 0
    @IBInspectable let shadowOffSetHeight : Int = 5
    @IBInspectable var shadowOpacity : Float = 0.5
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = shadowOpacity
    }
    
}
