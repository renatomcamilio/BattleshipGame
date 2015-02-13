//
//  FleetSetupViewController.swift
//  Battleship
//
//  Created by Renato Camilio on 2/9/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import UIKit

class FleetSetupViewController: UIViewController {
    
    var fleetViewController: FleetViewController?
    
    
    var player = Player(ownFleet: Fleet.generateFleet(), name: "Player 1", opponentFleet: nil)
    var CPU = Player(ownFleet: Fleet.generateFleet(), name: "CPU", opponentFleet: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player.opponentFleet = CPU.ownFleet
        CPU.opponentFleet = player.ownFleet
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "startBattle" {
            let newVC = segue.destinationViewController as BattleViewController
            
            // prepare to Battle!
            var newBattle = Battle(player: player, opponent: CPU)
            newVC.battle = newBattle
        } else if segue.identifier == "playerFleet" {
            let fleetVC = segue.destinationViewController as FleetViewController
            
            fleetVC.player = player
            fleetVC.opponent = CPU
            fleetVC.mode = .Player
            self.fleetViewController = fleetVC
            
        }
    }
    
    @IBAction func newFleetWasPressed(sender: AnyObject) {
        self.player.ownFleet = Fleet.generateFleet()
        self.fleetViewController?.refreshView()
    }
}
