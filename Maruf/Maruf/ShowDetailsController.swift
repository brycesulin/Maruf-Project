//
//  ShowDetailsController.swift
//  Maruf
//
//  Created by Aaron Diaz on 2/23/18.
//  Copyright © 2018 BryceSulin. All rights reserved.
//

import UIKit

class ShowDetailsController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var event:EventObject?
    
    // This function is used for adding the event to the native
    // iOS calendar
    @IBAction func addToCalendar(_ sender: UIButton) {
        
    // ** DELETE THIS CODE
        let alertController = UIAlertController(title: "Implement me! :o", message:
            "Once this button clicked, add event details to the calendar screen", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Yes master, right away master", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    // * DELETE THIS CODE
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = event?.titleOfEvent
        descriptionLabel.text = event?.descOfEvent
        locationLabel.text = event?.locationOfEvent
        dateLabel.text = event?.dateOfEvent

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
