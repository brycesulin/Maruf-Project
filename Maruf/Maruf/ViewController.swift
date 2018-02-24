//
//  ViewController.swift
//  Maruf
//
//  Created by Aaron Diaz on 11/24/17.
//  Copyright © 2017 BryceSulin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var events: [EventObject]? = []

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        fetchEvents()
    }
    
    func fetchEvents() {
        let urlRequest = URLRequest(url: URL(string: "https://maruf-events.herokuapp.com/Calendars/marufappscheduling@gmail.com/events")!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                print(error as Any)
                return
            }
            
            // Create array of events to populate when parsing JSON
            self.events = [EventObject]()
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                
                if let eventsFromJson = json["items"] as? [[String: AnyObject]] {
                    for eventFromJson in eventsFromJson {
                        let event = EventObject()
                        
                        // Stores all the values from the JSON dictionary into variables to be used
                        // for the tableview
                        if let title = eventFromJson["summary"] as? String, let description = eventFromJson["description"] as? String, let location = eventFromJson["location"] as? String, let start = eventFromJson["start"] as? [String: String] {
                            event.descOfEvent = description
                            event.titleOfEvent = title
                            event.locationOfEvent = location
                            
                            // Since the event date is nested, need to extract it from the start dictionary as well
                            let dateEvent = start["dateTime"]
                            
                            // This DateFormatter will turn the JSON parsed string date into
                            // a more easily readable one by converting it to a Date object first
                            let formattedDate = DateFormatter()
                            formattedDate.locale = Locale(identifier: "en_US_POSIX")
                            formattedDate.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
                            formattedDate.timeZone = TimeZone(secondsFromGMT: 0)
                            let date = formattedDate.date(from:dateEvent!)
                            
                            // Finally, add it to the event object for use with the labels
                            // toString is used here to get the correct display of the date
                            event.dateOfEvent = date?.toString()
                        }
                        
                        // Puts events into the array
                        self.events?.append(event)
                    }
                }
                
                // Refresh tableview data
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
                
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }

    /**
     * This method is used to set the label text for each label in the Event cell
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EventCell
        
        // Set the text for each label depending on its type
        cell.titleLabel.text = self.events?[indexPath.item].titleOfEvent
        cell.descLabel.text = self.events?[indexPath.item].descOfEvent
        cell.dateLabel.text = self.events?[indexPath.item].dateOfEvent
        cell.locationLabel.text = self.events?[indexPath.item].locationOfEvent
        
        // return the cell to be displayed
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // If not nil, use count value but if nil, returns 0 and won't crash
        return self.events?.count ?? 0
    }

    // ** ADDED ** \\
    // This method is used to perform the segue to the showDetails screen when an event is clicked
    // inside of the event screen
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    // ** ADDED ** \\
    // This method is used to show the selected events data on the screen for the user
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ShowDetailsController {
            destination.event = events?[(tableview.indexPathForSelectedRow?.row)!]
        }
    }
}

/**
 * This method is used to download an image from the JSON
 */
extension UIImageView {
    func downloadImage(from url: String) {
        
        let urlRequest = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil {
                print(error as Any)
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}

/**
 * This method is used to take a Date object and print it out
 * in a neat, cleaner format such as: Oct 9, 1994
 */
extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self)
    }
}
