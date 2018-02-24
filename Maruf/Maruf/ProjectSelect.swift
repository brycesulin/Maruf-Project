//
//  ProjectSelect.swift
//  Maruf
//
//  Created by Bryce Sulin on 9/26/17.
//  Copyright © 2017 BryceSulin. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import GoogleSignIn

class ProjectSelect: UIViewController {
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        
    }
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {}
    @IBAction func TopsunwindToMenu(segue: UIStoryboardSegue) {}
    @IBAction func PovertunityunwindToMenu(segue: UIStoryboardSegue) {}
    @IBAction func HeartunwindToMenu(segue: UIStoryboardSegue) {}
    @IBAction func FaithunwindToMenu(segue: UIStoryboardSegue) {}
    @IBAction func GardenunwindToMenu(segue: UIStoryboardSegue) {}
    
    @IBAction func eventsUnwindToProjects(segue: UIStoryboardSegue) {}

    
    
    //@IBAction func EventunwindToMenu(segue: UIStoryboardSegue) {}
    
    





    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class TableSectionHeader: UITableViewHeaderFooterView {
        
    }
    
    

}

