  //Povertunity.swift
  //  Maruf
  //
  //  Created by Bryce Sulin on 9/26/17.
  //  Copyright © 2017 BryceSulin. All rights reserved.
  //
  
  import UIKit
  
  class Povertunity: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, ProjectAbout {
    
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
            performSegue(withIdentifier: "Povertunity-Tops", sender: self)
        }
        else if (row == 2) {
            performSegue(withIdentifier: "Povertunity-Heart", sender: self)
        }
        else if (row == 3) {
            performSegue(withIdentifier: "Povertunity-HalfOfFaith", sender: self)
        }
        else if (row == 4) {
            performSegue(withIdentifier: "Povertunity-CommunityGardens", sender: self)
        }
        else if (row == 5) {
            performSegue(withIdentifier: "Povertunity-Center", sender: self)
        }
    }
    
    var projectTitle: String?
    var projectDescription: String?
    var projectAbout: String?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var aboutTextView: UITextView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var youtubeView: UIWebView!
    
    @IBAction func projectsReturn(_ sender: UIButton) {
        /* let alert = UIAlertController(title: "Return to ProjectSelect?", message: "Returning to Projects screen", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Return", style: UIAlertActionStyle.default, handler: {
            (_)in
            self.performSegue(withIdentifier: "PovertunityunwindToMenu", sender: self)
        })
        
        alert.addAction(OKAction)
        self.present(alert, animated: true, completion: nil) */
        
        self.performSegue(withIdentifier: "PovertunityunwindToMenu", sender: self)
    }
    
    func save() {
        
    }
    
    let pickerDataSource = ["Povertunity", "TOPS", "HEART", "Half of Faith", "Community Garden", "Center"];

    

    
    @IBAction func switchProject(_ sender: UIBarButtonItem) {
        pickerView.isHidden = !pickerView.isHidden;
        youtubeView.isHidden = youtubeView.isHidden;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        
        getVideo(videoCode: "4H5fH6FaR9c")
    }
    
    func getVideo(videoCode:String) {
        let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
        youtubeView.loadRequest(URLRequest(url: url!))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


  }
