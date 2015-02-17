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
    var player1: Player?
    var player2: Player?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        fleetViewController!.collectionView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "startBattle" {
            let newVC = segue.destinationViewController as BattleViewController
            
            // prepare to Battle!
            var newBattle = Battle(players: [player1!, player2!])
            newBattle.save()
            
            newVC.battle = newBattle
        } else if segue.identifier == "playerFleet" {
            let fleetVC = segue.destinationViewController as FleetViewController
            
            let player1Fleet = Fleet.generateFleet()
            let player2Fleet = Fleet.generateFleet()
            
            player1 = Player(ownFleet: player1Fleet, name: "Player 1", opponentFleet: player2Fleet)
            player2 = Player(ownFleet: player2Fleet, name: "Player 2", opponentFleet: player1Fleet)
            
            fleetVC.player = player1
            fleetVC.opponent = player2
            fleetVC.mode = .Player
            self.fleetViewController = fleetVC
        }
    }
    
    @IBAction func newFleetWasPressed(sender: AnyObject) {
        self.player1!.ownFleet = Fleet.generateFleet()
        self.fleetViewController?.refreshView()
    }
    
    @IBAction func unwindWithRematch(segue: UIStoryboardSegue) {
        player2!.ownFleet = Fleet.generateFleet()
        player1!.ownFleet = Fleet.generateFleet()
        
        fleetViewController!.collectionView?.reloadData()
    }
}
