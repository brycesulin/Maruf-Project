//
//  EventViewController.swift
//  Maruf
//
//  Created by Aaron Diaz on 12/2/17.
//  Copyright © 2017 BryceSulin. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {
    
    var event: EventObject!
    
    @IBOutlet weak var cardView: DesignView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventPrice: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTitle.text = event.titleOfEvent
        date.text = event.dateOfEvent
        eventDescription.text = event.descOfEvent
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
