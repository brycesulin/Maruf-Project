//
//  Events.swift
//  Maruf
//
//  Created by Aaron Diaz on 9/26/17.
//  Copyright © 2017 BryceSulin. All rights reserved.
//

import UIKit
import GoogleSignIn

class Events: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var eventItems: [Items]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.separatorColor = UIColor(white: 0.95, alpha: 1)
        //tableView.dataSource = self
        //tableView.delegate = self
        
        fetchEvents()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventItems?.count ?? 0
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EventCellTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EventCellTableViewCell
        cell.contentView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        //cell.textLabel?.text = self.eventItems?[indexPath.item].summaryTitle
        //cell.detailTextLabel?.text = self.eventItems?[indexPath.item].eventDescription
        return cell
    }

    
    
    // This function is used to parse the JSON response from the server that holds all the events created by
    // the 'marufappscheduling' gmail account
    func fetchEvents() {
        
        // Holds the URL to access the JSON response
        let url = URL(string: "https://maruf-events.herokuapp.com/Calendars/marufappscheduling@gmail.com/events")
        
        // If there is data, no problem. If the session does not get any response or data, then an error
        // will be generated
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            
            // Do loop to store the json object and try to parse the items within it
            // if succuessful prints the items else produces an error to print to the console
            self.eventItems = [Items]()
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                let items = json["items"] as? [[String: Any]]
                for itemFromJson in items! {
                    let itemArticle = Items()
                    if let title = itemFromJson["summary"] as? String,
                        let description = itemFromJson["description"] as? String {
                        itemArticle.summaryTitle = title
                        itemArticle.eventDescription = description
                    }
                    self.eventItems?.append(itemArticle)
                }
                //print(items as Any)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error as NSError {
                print(error)
            }
        }).resume()
    }
    
    // Helper for showing an alert
    func showAlert(title : String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.default,
            handler: nil
        )
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
