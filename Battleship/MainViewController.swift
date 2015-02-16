//
//  ViewController.swift
//  Battleship
//
//  Created by Renato Camilio on 2/7/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    let button: UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    
    @IBOutlet weak var loginButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.value), 0)) { // 1
            var currentUser = PFUser.currentUser()
            dispatch_async(dispatch_get_main_queue()) { // 2
                if currentUser != nil {
                    // Do stuff with the user
                    self.loginButton.title = currentUser.username
                } else {
                    // Show the signup or login screen
                    self.loginButton.title = "Login"
                }
            }
        }

        


    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {        
        if segue.identifier! == "showGameMode" {

        }
        if segue.identifier! == "showFleetSetup" {

        }
        
        if segue.identifier! == "showLogin" {
            
        }
    }
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
        
    }

    
    

}

