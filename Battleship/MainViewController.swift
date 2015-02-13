//
//  ViewController.swift
//  Battleship
//
//  Created by Renato Camilio on 2/7/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {        
        if segue.identifier! == "showGameMode" {

        } else if segue.identifier! == "showFleetSetup" {

        }
    }
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
        
    }

}

