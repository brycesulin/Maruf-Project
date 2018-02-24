//
//  ViewController.swift
//  Maruf
//
//  Created by Aaron Diaz on 10/1/17.
//  Copyright © 2017 Maruf. All rights reserved.
//

import UIKit

import FacebookLogin
import FBSDKLoginKit
import GoogleSignIn
import Firebase

class Login: UIViewController, GIDSignInUIDelegate, FBSDKLoginButtonDelegate, GIDSignInDelegate{
    
    var dict : [String : AnyObject]!
    
    @IBAction func moveToTabBar(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = tabBarController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call to functions that generate the Google and FB Login buttons
        GIDSignIn.sharedInstance().signOut()
        setupGoogleButtons()
        setupFacebookButtons()
        
        // Set the delegate in order for the google-sign in button to appear
        GIDSignIn.sharedInstance().delegate = self

        
    }
    
    // This function is used for the google sign in. If the user fails to login, message
    // will be printed to the console and the user will be kicked back to the login screen
    // but if a successful login, user will be violently pushed to the home screen
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let err = error {
            print("Failed to log in with Google: ", err)
            return
        }
        
        print("Successfully logged in with Google!")
        guard let idToken = user.authentication.idToken else {return}
        guard let accessToken = user.authentication.accessToken else {return}
        let credentials = FIRGoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        // Checks to make sure that a successful login occurred
        FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
            if let err = error {
                print("Failed to log in with Google Firebase: ", err)
                return
            }
            print("Successfully logged in with Google Firebase!")
            
            // Moves user to main screen after logging in with gmail
            let viewController = self.storyboard!.instantiateViewController(withIdentifier: "TabBarController") as UIViewController
            self.present(viewController, animated: true, completion: nil)
        })
        
    }
    
    // Function that says logout was successful
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User logged out of Facebook")
    }
    
    // Function that says login was a success
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        showEmailAddress()
        
        // After user logs in with FB, will violently throw them into the homescreen
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: "TabBarController") as UIViewController
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Function to show the email address of the user signing in
    func showEmailAddress() {
        
        // Variables to get the user tokens for authentication
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else {return}
        
        // Determines if the credentials are valid  and will either allow the user
        // to login or kick it out
        let credentials = FIRFacebookAuthProvider.credential(withAccessToken: (accessTokenString))
        FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
            if error != nil {
                print("FB Firebase authentication issue: ", error as Any)
                return
            }
            
            print("Successfully logged in with FB and Firebase!")
        })
        
        // FB method that grabs the email used with their facebook account
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start {
            (connection, result, err) in
            
            if err != nil {
                print("Failed to start graph request:", err as Any)
            }
            
            print(result as Any)
        }
    }
    
    // Function that creates the google sign in button
    fileprivate func setupGoogleButtons() {
        let googleButton = GIDSignInButton()
        googleButton.frame = CGRect(x: 16, y: 250, width: view.frame.width - 32, height: 50)
        view.addSubview(googleButton)
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    // Function that creates a facebook sign in button
    fileprivate func setupFacebookButtons() {
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        loginButton.frame =  CGRect(x: 16, y: 250 + 66, width: view.frame.width - 32, height: 50)
        loginButton.delegate = self
        loginButton.readPermissions = ["email", "public_profile"]
    }
}
