//
//  AddUserViewController.swift
//  Battleship
//
//  Created by Michael Reining on 2/10/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import UIKit

class AddUserViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate, UIActionSheetDelegate {
    let signupButton: UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    let loginButton: UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    let signUpLabel = UILabel(frame: CGRectMake(0, 0, 300, 30))
    let usernameTextField = UITextField(frame: CGRectMake(20.0, 30.0, 300, 30))
    let emailTextField = UITextField(frame: CGRectMake(20.0, 30.0, 300, 30))
    let passwordTextField = UITextField(frame: CGRectMake(20.0, 30.0, 300, 30))
    var currentUser: PFUser?
    var userID: String?

    //MARK:
    // NOTE: I created this view programmatically so that we could avoid conflicts on the StoryBoard.  :-)
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor()
        
        // Add Login Button
        loginButton.frame = CGRectMake(20.0, 100, 300, 30)
        loginButton.setTitle("Login", forState: UIControlState.Normal)
        loginButton.addTarget(self, action: "loginButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(loginButton)
        
        // Display SignUp Label
        signUpLabel.center = CGPointMake(170, 200)
        signUpLabel.text = "Not registered? Signup below"
        signUpLabel.textAlignment = .Left
        let labelFont = UIFont(name: "HelveticaNeue", size: 16)
        signUpLabel.font = labelFont
        view.addSubview(signUpLabel)
        
        // Add Username Text Field
        usernameTextField.center = CGPointMake(170, 265)
        usernameTextField.backgroundColor = UIColor.whiteColor()
        usernameTextField.placeholder = " Add username"
        usernameTextField.returnKeyType = .Next
        self.view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        
        // Add Email Text Field
        emailTextField.center = CGPointMake(170, 295)
        emailTextField.backgroundColor = UIColor.whiteColor()
        emailTextField.placeholder = " Add email address"
        emailTextField.returnKeyType = .Next
        self.view.addSubview(emailTextField)
        emailTextField.delegate = self
        
        // Add Password Text Field
        passwordTextField.center = CGPointMake(170, 325)
        passwordTextField.backgroundColor = UIColor.whiteColor()
        passwordTextField.placeholder = " Add password"
        passwordTextField.returnKeyType = .Next
        self.view.addSubview(passwordTextField)
        passwordTextField.delegate = self
        
        // Add Signup Button
        signupButton.frame = CGRectMake(20.0, 355, 300, 30)
        signupButton.setTitle("Signup", forState: UIControlState.Normal)
        signupButton.addTarget(self, action: "signupButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(signupButton)
        
        
    }
    
    // MARK Login & SignUp
    
    func loginButtonPressed() {
        let alertController = UIAlertController(title: "Login to Battleship", message: "Please enter your username and password.", preferredStyle: .Alert)
        
        let loginAction = UIAlertAction(title: "Login", style: .Default) { (_) in
            // login logic goes here
            let usernameTextField = alertController.textFields![0] as UITextField
            let passwordTextField = alertController.textFields![1] as UITextField
            
            PFUser.logInWithUsernameInBackground(usernameTextField.text,
                password: passwordTextField.text,
                block: {
                    (user, error) in
                    // Capture user details on login
                    self.currentUser = PFUser.currentUser()
                } 
            )
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Username"
            
            NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification, object: textField, queue: NSOperationQueue.mainQueue()) { (notification) in
                loginAction.enabled = textField.text != ""
            }
        }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Password"
            textField.secureTextEntry = true
        }
        
        alertController.addAction(loginAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true) {
            // ...
        }

    }
    

    

    
    func signupButtonPressed() {
        var userEntered = usernameTextField.text
        var emaillEntered = emailTextField.text
        var passwordEntered = passwordTextField.text
        if userEntered != "" && emaillEntered != "" && passwordEntered != "" {
            // If signup looks valid, save login in Parse
            userSignUp(userEntered, email: emaillEntered, password: passwordEntered)
        } else {
            // If signup is invalid show alert view
            var alert = UIAlertController(title: "Missing Details", message: "Please check the form and try again.", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "Ok, got it!", style: .Default) { (action: UIAlertAction!) -> Void in
                // do something here if necessary
            }
            
            alert.addAction(okAction)
            
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func userSignUp(username: String, email: String, password: String) {
        var user = PFUser()
        user.username = username
        user.email = email
        user.password = password
        user.signUpInBackgroundWithBlock { (success, error) -> Void in
            if success {
                self.currentUser = PFUser.currentUser()
                self.userID = PFUser.currentUser().objectId!
                println(self.currentUser)
                println(self.userID)
                let alert = UIAlertController(title: "Success", message: "Your user account was added successfully", preferredStyle: .Alert)
                let action = UIAlertAction(title: "Sweet!", style: .Default) { (action: UIAlertAction!) -> Void in
                }
                alert.addAction(action)
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Something went wrong", message: "Please try again", preferredStyle: .Alert)
                let action = UIAlertAction(title: "Ok, got it!", style: .Default) { (action: UIAlertAction!) -> Void in
                }
                alert.addAction(action)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
}
