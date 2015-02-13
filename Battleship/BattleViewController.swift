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
        } else if segue.identifier == "showBattleEndDashboard" {
            println("\(battle?.activePlayer!.name) won the game")
        }
    }
    
    func prepareForNextTurn() {
        // TODO;"DOTO" - Mike :)
        
        // Description:
        // Set the "focus" to  activePlayer fleet and "blur" its opponent's fleet
        //
        // My advice is to have one of that "Front UIView" in the opponent's fleet, 
        // and by default, the highlighted fleet is the activePlayer, which means that
        // it doesn't have any layer/view over it
        
        self.battle!.nextTurn({ isCPUPlayer in
            if isCPUPlayer {
                var shotAt = self.battle!.activePlayer?.calculateBestTargetToShootAt()
                var CPUTarget = NSIndexPath(forItem: shotAt!, inSection: 0)
                
                // CPU shoot at target
                self.playerSelectedCell(CPUTarget)
                
                self.playerCollectionView?.reloadData()
            }
        })
        
        roundLabel.text = "Round: \(String(self.battle!.round))"
        turnLabel.text = self.battle?.turn == 1 ? "Player turn" : "Opponent turn"
    }
    
    func playerSelectedCell(indexPath: NSIndexPath) {
        battle?.takeShot(indexPath, player: battle!.activePlayer!)
        
        // before preparing to the next turn, it's a good idea to check if the game as a winner
        // which means that the game has ended
        if battle!.gameHasWinner() {
            self.performSegueWithIdentifier("showBattleEndDashboard", sender: self)
        } else {
            self.prepareForNextTurn()
        }
    }
    
    // MARK: - User interaction
    @IBAction func giveUpWasPressed(sender: AnyObject) {
        // We should return the player to the initial screen
        // maybe define the opponent as winner, because the player is giving up
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
