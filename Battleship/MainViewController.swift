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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Add User button - programmatically - TO DO add to storyboard
        button.frame = CGRectMake(120, 180, 120, 50)
        button.setTitle("Add User", forState: UIControlState.Normal)
        button.addTarget(self, action: "addUserButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {        
        if segue.identifier! == "showGameMode" {

        } else if segue.identifier! == "showFleetSetup" {

        }
    }

    func addUserButtonPressed() {
        let vc = AddUserViewController(nibName: nil, bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    

}

