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
            
            self.opponentCollectionView = fleetVC.collectionView
            
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
    
    // MARK: - Battle logic
    func thereIsOpponentBoat(indexPathItem: Int) -> (Boat?) {
        for boat in self.battle!.opponent.ownFleet.boats {
            for square in boat.squares {
                if indexPathItem == square {
                    return (boat)
                }
            }
        }
        return (nil)
    }
    
    // TO DO: Make it work properly :p
    // It's not checking right when it's destroyd (it always return destroyed)
    func boatWasDestroyed(boat:Boat) -> Bool {
        var hits = [Int]()
        for square in boat.squares {
            if contains(self.battle!.activePlayer!.shotsTaken, square) {
                hits.append(square)
            }
        }

        return hits.count == boat.squares.count
    }
    
    func prepareForNextTurn() {
        self.battle!.nextTurn()
        
        self.roundLabel.text = "Round: \(String(self.battle!.round))"
        self.turnLabel.text = self.battle?.turn == 1 ? "Player turn" : "Opponent turn"
        
        // Update active player
        if self.battle!.activePlayer === self.battle!.player {
            self.battle!.activePlayer = self.battle!.opponent
            self.CPUTakeTurn()
        } else {
            self.battle!.activePlayer = self.battle!.player
        }
        
    }
    
    func CPUTakeTurn() {
        // it gets its opponent's fleet
        // generate a random target
        
        // Will do the smart shot
        // battle?.opponent.takeCPUShot()
        
        prepareForNextTurn()
    }
    
    func playerSelectedCell(indexPath: NSIndexPath) {
        self.battle?.activePlayer?.takeShot(indexPath.item)
        
        self.prepareForNextTurn()
    }
    
    // MARK: - User interaction
    @IBAction func giveUpWasPressed(sender: AnyObject) {
        // We should return the player to the initial screen
        // maybe define the opponent as winner, because the player is giving up
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
