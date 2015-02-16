//
//  AddUserViewController.swift
//  Battleship
//
//  Created by Michael Reining on 2/10/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import UIKit

class AddUserViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate, UIActionSheetDelegate {
    @IBOutlet weak var loginExistingUserButton: UIButton!
    @IBOutlet weak var addNewUserButton: UIButton!
    @IBOutlet weak var addPasswordTextField: UITextField!
    
    @IBOutlet weak var signupNewUserButton: UIButton!
    @IBOutlet weak var addEmailTextField: UITextField!
    @IBOutlet weak var addUsernameTextField: UITextField!
    var currentUser: PFUser?
    var userID: String?

    
    
    //MARK:
    // NOTE: I created this view programmatically so that we could avoid conflicts on the StoryBoard.  :-)
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor()
        addUsernameTextField.returnKeyType = .Next
        addUsernameTextField.delegate = self
        addEmailTextField.returnKeyType = .Next
        addEmailTextField.delegate = self
        addPasswordTextField.returnKeyType = .Done
        addPasswordTextField.delegate = self
        addUsernameTextField.hidden = true
        addEmailTextField.hidden = true
        addPasswordTextField.hidden = true
        signupNewUserButton.hidden = true
        
    }
    
    @IBAction func loginExistingUserButtonPressed(sender: AnyObject) {
        
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
                    self.userID = PFUser.currentUser().objectId!
                    let alert = UIAlertController(title: "Login Success", message: "You are now logged in as \(self.currentUser!.username)", preferredStyle: .Alert)
                    let action = UIAlertAction(title: "Awesome!", style: .Default) { (action: UIAlertAction!) -> Void in
                    }
                    alert.addAction(action)
                    self.presentViewController(alert, animated: true, completion: nil)

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
    
    @IBAction func addNewUserButtonPressed(sender: AnyObject) {
        addUsernameTextField.hidden = false
        addEmailTextField.hidden = false
        addPasswordTextField.hidden = false
        signupNewUserButton.hidden = false
        addUsernameTextField.becomeFirstResponder()

    }


    
    func userSignUp(username: String, email: String, password: String) {
        if username != "" && email != "" && password != "" {
            // If signup looks valid, save login in Parse
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
    
    @IBAction func signupNewUserButtonPressed(sender: AnyObject) {
        var username = addUsernameTextField.text
        var email = addEmailTextField.text
        var password = addPasswordTextField.text
        userSignUp(username, email: email, password: password)
        
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        if textField == addUsernameTextField {
            addUsernameTextField.resignFirstResponder()
            addEmailTextField.becomeFirstResponder()
            return true
        }
        
        if textField == addEmailTextField {
            addEmailTextField.resignFirstResponder()
            addPasswordTextField.becomeFirstResponder()
            return true
        }
        
        if textField == addPasswordTextField {
            addPasswordTextField.resignFirstResponder()
            userSignUp(addUsernameTextField.text, email: addEmailTextField.text, password: addPasswordTextField.text)
        }
        
        return false
    }

}
