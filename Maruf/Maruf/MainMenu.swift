//
//  MainMenu.swift
//  Maruf
//
//  Created by Bryce Sulin on 11/28/17.
//  Copyright © 2017 BryceSulin. All rights reserved.
//

import Foundation
import UIKit

class MainMenu: UIViewController {

    
    @IBAction func projectButtonTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "eventsUnwindToProject", sender: self)
    }
    
}
