//
//  EventPageViewController.swift
//  Maruf
//
//  Created by Aaron Diaz on 12/2/17.
//  Copyright © 2017 BryceSulin. All rights reserved.
//

import UIKit

class EventPageViewController: UIPageViewController {
    
    var recipeControllers = [EventViewController]()
    var events: [EventObject] = [] {
        didSet {
            setControllers()
        }
    }
    
    private func setControllers() {
        var n = 0
        if !events.isEmpty {
            repeat {
                n = n + 1
                if let controller = storyboard?.instantiateViewController(withIdentifier: "recipe") as? EventViewController {
                    controller.event = events[n - 1]
                    recipeControllers.append(controller)
                }
            } while(n < events.count)
        }
        if let initialViewController = recipeControllers.first {
            setViewControllers([initialViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchEvents()
        setControllers()
        self.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        for subView in self.view.subviews {
            if subView is UIScrollView {
                subView.frame = self.view.bounds
            } else if subView is UIPageControl {
                let pageControl = subView as! UIPageControl
                pageControl.currentPageIndicatorTintColor = UIColor(red:0.00, green:0.15, blue:0.29, alpha:1.0)
                pageControl.pageIndicatorTintColor = UIColor(red:0.00, green:0.15, blue:0.29, alpha:0.30)
                self.view.bringSubview(toFront: subView)
                
                
            }
        }
        super.viewDidLayoutSubviews()
    }
    
    func fetchEvents() {
        let urlRequest = URLRequest(url: URL(string: "https://maruf-events.herokuapp.com/Calendars/marufappscheduling@gmail.com/events")!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                print(error as Any)
                return
            }
            
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                
                if let eventsFromJson = json["items"] as? [[String: AnyObject]] {
                    
                    var eventlist: [EventObject] = []
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
                        eventlist.append(event)
                    }
                    // Refresh tableview data
                    DispatchQueue.main.async {
                        self.events = eventlist
                    }
                    
                }
                
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
    
    
}



extension EventPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let recipeController = viewController as? EventViewController,
            let viewControllerIndex = recipeControllers.index(of: recipeController) else {
                return nil
        }
        
        
        let previousIndex = viewControllerIndex - 1
        
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard recipeControllers.count > previousIndex else {
            return nil
        }
        
        return recipeControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let recipeController = viewController as? EventViewController,
            let viewControllerIndex = recipeControllers.index(of: recipeController) else{
                return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = recipeControllers.count
        
        // User is on the last view controller and swiped right to loop to
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return recipeControllers[nextIndex]
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return recipeControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let recipeController = pageViewController.viewControllers?.last as? EventViewController,
            let index = recipeControllers.index(of: recipeController) else{
                return 0
        }
        return index
    }
}
