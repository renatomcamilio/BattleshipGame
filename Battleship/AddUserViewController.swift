//
//  AddUserViewController.swift
//  Battleship
//
//  Created by Michael Reining on 2/10/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import UIKit

class AddUserViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate {
    

    //MARK: 
    // NOTE: I created this view programmatically so that we could avoid conflicts on the StoryBoard.  :-)
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor()
        
        // Display SignUp Label
        let signUpLabel = UILabel(frame: CGRectMake(0, 0, 300, 30))
        signUpLabel.center = CGPointMake(170, 120)
        signUpLabel.text = "Please Sign Up"
        signUpLabel.textAlignment = .Left
        let labelFont = UIFont(name: "HelveticaNeue", size: 20)
        signUpLabel.font = labelFont
        view.addSubview(signUpLabel)
        
        // Add Username Text Field
        let usernameTextField = UITextField(frame: CGRectMake(20.0, 30.0, 300, 30))
        usernameTextField.center = CGPointMake(170, 185)
        usernameTextField.backgroundColor = UIColor.whiteColor()
        usernameTextField.placeholder = " Add username"
        usernameTextField.returnKeyType = .Next
        self.view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        
        // Add Email Text Field
        let email = UITextField(frame: CGRectMake(20.0, 30.0, 300, 30))
        email.center = CGPointMake(170, 215)
        email.backgroundColor = UIColor.whiteColor()
        email.placeholder = " Add email"
        email.returnKeyType = .Next
        self.view.addSubview(email)
        email.delegate = self
        
        // Add Password Text Field
        let passwordTextField = UITextField(frame: CGRectMake(20.0, 30.0, 300, 30))
        passwordTextField.center = CGPointMake(170, 245)
        passwordTextField.backgroundColor = UIColor.whiteColor()
        passwordTextField.placeholder = " Add username"
        passwordTextField.returnKeyType = .Next
        self.view.addSubview(passwordTextField)
        passwordTextField.delegate = self
        
        // Add Signup Button
        let signupButton: UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        signupButton.frame = CGRectMake(20.0, 275, 300, 30)
        signupButton.setTitle("Signup", forState: UIControlState.Normal)
        signupButton.addTarget(self, action: "signupButton", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(signupButton)
        
        
    }
    
    func signupButton() {

    }
    
    
    
    
}
