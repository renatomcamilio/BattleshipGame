//
//  AddUserViewController.swift
//  Battleship
//
//  Created by Michael Reining on 2/10/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import UIKit

class AddUserViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate {
    let signupButton: UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
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
        
        // Display SignUp Label
        signUpLabel.center = CGPointMake(170, 120)
        signUpLabel.text = "Please Sign Up"
        signUpLabel.textAlignment = .Left
        let labelFont = UIFont(name: "HelveticaNeue", size: 20)
        signUpLabel.font = labelFont
        view.addSubview(signUpLabel)
        
        // Add Username Text Field
        usernameTextField.center = CGPointMake(170, 185)
        usernameTextField.backgroundColor = UIColor.whiteColor()
        usernameTextField.placeholder = " Add username"
        usernameTextField.returnKeyType = .Next
        self.view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        
        // Add Email Text Field
        emailTextField.center = CGPointMake(170, 215)
        emailTextField.backgroundColor = UIColor.whiteColor()
        emailTextField.placeholder = " Add email address"
        emailTextField.returnKeyType = .Next
        self.view.addSubview(emailTextField)
        emailTextField.delegate = self
        
        // Add Password Text Field
        passwordTextField.center = CGPointMake(170, 245)
        passwordTextField.backgroundColor = UIColor.whiteColor()
        passwordTextField.placeholder = " Add password"
        passwordTextField.returnKeyType = .Next
        self.view.addSubview(passwordTextField)
        passwordTextField.delegate = self
        
        // Add Signup Button
        signupButton.frame = CGRectMake(20.0, 275, 300, 30)
        signupButton.setTitle("Signup", forState: UIControlState.Normal)
        signupButton.addTarget(self, action: "signupButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(signupButton)
        
        
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
