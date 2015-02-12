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
            let destinationVC = segue.destinationViewController as PlayerCollectionViewController
            self.playerCollectionView = destinationVC.collectionView
            
            destinationVC.battleDelegate = self
            self.playerCollectionView = destinationVC.collectionView
        } else if segue.identifier == "opponentFleet" {
            let destinationVC = segue.destinationViewController as OpponentCollectionViewController
            self.opponentCollectionView = destinationVC.collectionView
            
            destinationVC.battleDelegate = self
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
    
    func prepareForNextRound() {
        self.battle!.round += 1
        self.roundLabel.text = "Round: \(String(self.battle!.round))"
        // Update active player
        if self.battle!.activePlayer === self.battle!.player {
            self.battle!.activePlayer = self.battle!.opponent
            //self.CPUTakeTurn()
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
        
        self.prepareForNextRound()
    }
    
    func playerSelectedCell(indexPath: NSIndexPath) {
        // update shots taken
        self.battle?.activePlayer?.shotsTaken.append(indexPath.item)
        
        var cell = self.opponentCollectionView!.cellForItemAtIndexPath(indexPath) as FleetSquareCollectionViewCell
        // was it a hit?
        var possibleBoat = thereIsOpponentBoat(indexPath.item)
        if let boatThatWasHit = possibleBoat {
            // color cell red
            
            cell.backgroundColor = UIColor.redColor()
            // check if boat was destroyed
            self.battle!.activePlayer!.targetsHit.append(indexPath.item)
            if boatWasDestroyed(boatThatWasHit) {
                // Boat destroyed do something
                println("My \(boatThatWasHit.size.rawValue) was destroyd!")
                
                if self.battle!.gameHasEnded() {
                    println("Active Player won!")
                    
                    self.battle?.winner = self.battle?.activePlayer
                }
            } else {
                // Boat hit but not destroyed do something
                // like updating the targesHit number
            }
        } else {
            // water was hit.  Do something
            cell.backgroundColor = UIColor.cyanColor()
        }
        
        self.prepareForNextRound()
    }
    
    // MARK: - User interaction
    @IBAction func giveUpWasPressed(sender: AnyObject) {
        // We should return the player to the initial screen
        // maybe define the opponent as winner, because the player is giving up
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
