//
//  Center.swift
//  Maruf
//
//  Created by Bryce Sulin on 10/28/17.
//  Copyright © 2017 BryceSulin. All rights reserved.
//

import UIKit


class Center: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, ProjectAbout {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let selected = pickerDataSource[row]
        
        return selected
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if (row == 0) {
        }
        else if (row == 1) {
            performSegue(withIdentifier: "Center-Tops", sender: self)
        }
        else if (row == 2) {
            performSegue(withIdentifier: "Center-Povertunity", sender: self)
        }
        else if (row == 3) {
            performSegue(withIdentifier: "Center-Heart", sender: self)
        }
        else if (row == 4) {
            performSegue(withIdentifier: "Center-HalfOfFaith", sender: self)
        }
        else if (row == 5) {
            performSegue(withIdentifier: "Center-CommunityGardens", sender: self)
        }
    }

    

    var projectTitle: String?
    var projectDescription: String?
    var projectAbout: String?
    
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var youtubeVideo: UIWebView!
    

    
    @IBAction func projectsReturn(_ sender: UIButton) {
        /*let alert = UIAlertController(title: "Return to Projects", message: "Returning to Project Select", preferredStyle: .alert)
        let ReturnAction = UIAlertAction(title: "Return", style: UIAlertActionStyle.default, handler: {
            (_)in
            self.performSegue(withIdentifier: "unwindToMenu", sender: self)
        })
        
        alert.addAction(ReturnAction)
        self.present(alert, animated: true, completion: nil)*/
        
        self.performSegue(withIdentifier: "unwindToMenu", sender: self)
    }
    
    
    let pickerDataSource = ["Center", "TOPS", "Povertunity", "HEART", "Half of Faith", "Community Garden"];


    
    
    func save() {
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;

        getVideo(videoCode: "14HER0m1Sbk")
    }
    
    func getVideo(videoCode:String) {
        let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
        youtubeVideo.loadRequest(URLRequest(url: url!))
    }
    
    
  
    @IBAction func switchProjects(_ sender: UIBarButtonItem) {
        pickerView.isHidden = !pickerView.isHidden;
        youtubeVideo.isHidden = youtubeVideo.isHidden;
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
