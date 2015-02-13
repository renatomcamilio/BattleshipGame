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
                var shotAt = self.battle!.activePlayer?.calculateBestTargetToShootAt()
                var CPUTarget = NSIndexPath(forItem: shotAt!, inSection: 0)
                
                self.playerSelectedCell(CPUTarget)
                
                self.playerCollectionView?.reloadData()
            }
        })
        
        self.roundLabel.text = "Round: \(String(self.battle!.round))"
        self.turnLabel.text = self.battle?.turn == 1 ? "Player turn" : "Opponent turn"
    }
    
    func playerSelectedCell(indexPath: NSIndexPath) {
        self.battle?.takeShot(indexPath, player: self.battle!.activePlayer!)
        self.prepareForNextTurn()
    }
    
    // MARK: - User interaction
    @IBAction func giveUpWasPressed(sender: AnyObject) {
        // We should return the player to the initial screen
        // maybe define the opponent as winner, because the player is giving up
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
