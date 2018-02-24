  //HalfOfFaith.swift
  //  Maruf
  //
  //  Created by Bryce Sulin on 9/26/17.
  //  Copyright © 2017 BryceSulin. All rights reserved.
  //
  
  import UIKit
  
  class HalfOfFaith: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, ProjectAbout  {
    
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
            performSegue(withIdentifier: "HalfOfFaith-Tops", sender: self)
        }
        else if (row == 2) {
            performSegue(withIdentifier: "HalfOfFaith-Povertunity", sender: self)
        }
        else if (row == 3) {
            performSegue(withIdentifier: "HalfOfFaith-Heart", sender: self)
        }
        else if (row == 4) {
            performSegue(withIdentifier: "HalfOfFaith-CommunityGardens", sender: self)
        }
        else if (row == 5) {
            performSegue(withIdentifier: "HalfOfFaith-Center", sender: self)
        }
    }
    
    var projectTitle: String?
    var projectDescription: String?
    var projectAbout: String?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var aboutTextView: UITextView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var youtubeVideo: UIWebView!
    
    
    @IBAction func projectsReturn(_ sender: UIButton) {
      /*  let alert = UIAlertController(title: "Return to ProjectSelect?", message: "Returning to Projects screen", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Return", style: UIAlertActionStyle.default, handler: {
            (_)in
            self.performSegue(withIdentifier: "FaithunwindToMenu", sender: self)
        })
        
        alert.addAction(OKAction)
        self.present(alert, animated: true, completion: nil) */
         self.performSegue(withIdentifier: "FaithunwindToMenu", sender: self)
    }
    
    
    
    
    
    func save() {
        
    }
    
    let pickerDataSource = ["Half of Faith", "TOPS", "Povertunity", "HEART", "Community Garden", "Center"];
    

    
    @IBAction func switchProject(_ sender: UIBarButtonItem) {
        pickerView.isHidden = !pickerView.isHidden;
        youtubeVideo.isHidden = youtubeVideo.isHidden;
    }
    
    func getVideo(videoCode:String) {
        let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
        youtubeVideo.loadRequest(URLRequest(url: url!))
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        
        getVideo(videoCode: "ls24hfqaMV0")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
  }
  
  

