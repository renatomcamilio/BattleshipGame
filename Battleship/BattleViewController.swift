//
//  BattleViewController.swift
//  Battleship
//
//  Created by Renato Camilio on 2/10/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var turnLabel: UILabel!
    
    var battle: Battle?
    var opponentCollectionView: UICollectionView?
    var playerCollectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "playerFleet" {
            let fleetVC = segue.destinationViewController as FleetViewController
            fleetVC.player = battle?.player
            fleetVC.opponent = battle?.opponent
            fleetVC.mode = .Player
            
            self.playerCollectionView = fleetVC.collectionView
            
            fleetVC.battleDelegate = self
        } else if segue.identifier == "opponentFleet" {
            let fleetVC = segue.destinationViewController as FleetViewController
            
            fleetVC.player = battle?.opponent
            fleetVC.opponent = battle?.player
            fleetVC.mode = .Opponent
            
            self.opponentCollectionView = fleetVC.collectionView
            
            fleetVC.battleDelegate = self
        }
    }
    
    func prepareForNextTurn() {
        self.battle!.nextTurn({ isCPUPlayer in
            if isCPUPlayer {
                var CPUTarget = NSIndexPath(forItem: Int(arc4random_uniform(UInt32(100))), inSection: 0)
                
                // try that target out
                self.playerSelectedCell(CPUTarget)
                
                self.playerCollectionView?.reloadData()
            }
        })
        
        self.roundLabel.text = "Round: \(String(self.battle!.round))"
        self.turnLabel.text = self.battle?.turn == 1 ? "Player turn" : "Opponent turn"
        
        // Update active player
        if self.battle!.activePlayer === self.battle!.player {
            self.battle!.activePlayer = self.battle!.opponent
            self.CPUTakeTurn()

        } else {
            self.battle!.activePlayer = self.battle!.player
            
        }
        //opponentCollectionView?.reloadData()

        // Update the collection views - load active player fleet and his opponents fleet
        
        // Reqeust player to take a turn: add UILabel "Please select a target"
    }
    
    func CPUTakeTurn() {
        // it gets its opponent's fleet
        // generate a random target
        
        if let b = battle {
            var shootAt = b.activePlayer?.calculateBestTargetToShootAt()
            println("Shots Taken: \(b.activePlayer?.shotsTaken)")
            println("Opponent Positions: \(b.activePlayer?.opponentFleet?.takenPositions)")
            println("Targets Hit: \(b.activePlayer?.targetsHit)")
            println("Active Hits: \(b.activePlayer?.activeHits)")
            println("Shoot at: \(shootAt)")
            
            b.takeShot(shootAt!, player: b.activePlayer!)
            
            prepareForNextTurn()
        }
    }
    
    func playerSelectedCell(indexPath: NSIndexPath) {
        self.battle?.takeShot(indexPath.item, player: self.battle!.activePlayer!)
        self.prepareForNextTurn()
    }
    
    // MARK: - User interaction
    @IBAction func giveUpWasPressed(sender: AnyObject) {
        // We should return the player to the initial screen
        // maybe define the opponent as winner, because the player is giving up
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
