//
//  BattleParse.swift
//  Battleship
//
//  Created by Renato Camilio on 2/16/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import Foundation

class BattleParse: PFObject, PFSubclassing {
    
    @NSManaged var player1: Player
    @NSManaged var player2: Player
    @NSManaged var activePlayer: Player
    @NSManaged var winner: Player?
    @NSManaged var turn: Int
    @NSManaged var round: Int
 
    
    class func parseClassName() -> String! {
        return "BattleParse"
    }
    
    override class func load() {
        self.registerSubclass()
    }
    
    init(players: [Player]) {
        super.init()

        self.player1 = players.first!
        self.player2 = players.last!
        
        let startingPlayerIndex = Int( arc4random_uniform( UInt32(2) ) )
        self.activePlayer = players[startingPlayerIndex]
        
        self.saveInBackgroundWithBlock { (success: Bool, error: NSError!) -> Void in
            if success {
                println("Success: \(self)")
            } else {
                println("Error: \(error.userInfo!)")
            }
        }
    }
    
    func takeShot(indexPath: NSIndexPath, player: Player) {
        let index = indexPath.item
        
        player.shotsTaken.append(index)
        
        println("shooting at \(player.opponentFleet?.takenPositions)")
        
        if contains(player.opponentFleet?.takenPositions ?? [Int](), index) {
            player.activeHits.append(index)
            player.targetsHit.append(index)
            
            println("hit at \(index)")
        } else {
            println("missed at \(index)")
        }
    }
    
    func nextTurn(turnHandler: (Bool) -> (Void)) {
        if turn == 2 {
            round += 1
            turn = 1
        } else {
            turn += 1
        }
        
        // we'll need a BattleTurn object on Parse, which contains:
        //  - battle_id related to both players like shotsTaken, targetsHit?, takenPositions
        // the last line for BattleTurn represents the current turn
        
        // Update active player in game and send it to Parse
        if self.activePlayer === self.player1 {
            self.activePlayer = self.player2
            turnHandler(false)
        } else {
            self.activePlayer = self.player1
            turnHandler(false)
        }
        
        // Save Parse Object in background
    }
    
    func gameHasWinner() -> Bool {
        var isThereAWinner = activePlayer.targetsHit.count == activePlayer.opponentFleet?.takenPositions.count
        
        if isThereAWinner {
            winner = activePlayer
        }
        
        return isThereAWinner
    }
    
    func rematch() {
        player1.shotsTaken = [Int]()
        player1.targetsHit = [Int]()
        player1.activeHits = [Int]()
        
        player2.shotsTaken = [Int]()
        player2.targetsHit = [Int]()
        player2.activeHits = [Int]()
        
        // maybe regenerate the fleets here
        // then start a new game through Parse
    }
    
}