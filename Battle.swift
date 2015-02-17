//
//  BattleParse.swift
//  Battleship
//
//  Created by Renato Camilio on 2/16/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import Foundation

class Battle: PFObject, PFSubclassing {
    
    @NSManaged var player1: Player
    @NSManaged var player2: Player
    @NSManaged var activePlayer: Player
    @NSManaged var winner: Player?
    @NSManaged var turn: Int
    @NSManaged var round: Int
    
    
    init(players: [Player]) {
        super.init()
        
        player1 = players.first!
        player2 = players.last!
        
        turn = 1
        round = 1
        
//        let startingPlayerIndex = Int( arc4random_uniform( UInt32(2) ) )
        let startingPlayerIndex = 0

        activePlayer = players[startingPlayerIndex]
    }
    
    func takeShot(indexPath: NSIndexPath) {
        let index = indexPath.item
        
        activePlayer.shotsTaken.append(index)
        
        println("shooting at \(activePlayer.opponentFleet!.takenPositions)")
        
        if contains(activePlayer.opponentFleet!.takenPositions ?? [Int](), index) {
            activePlayer.activeHits.append(index)
            activePlayer.targetsHit.append(index)
            
            println("hit at \(index)")
        } else {
            println("missed at \(index)")
        }
        
        activePlayer.save()
    }
    
    func gameHasWinner() -> Bool {
        var isThereAWinner = activePlayer.targetsHit.count == activePlayer.opponentFleet!.takenPositions.count
        
        if isThereAWinner {
            winner = activePlayer
        }
        
        return isThereAWinner
    }
    
    func nextTurn(turnHandler: (Bool) -> (Void)) {
        if turn == 2 {
            round += 1
            turn = 1
        } else {
            turn += 1
        }
        
        // Update active player in game and send it to Parse
        if self.activePlayer === self.player1 {
            self.activePlayer = self.player2
            turnHandler(false)
        } else {
            self.activePlayer = self.player1
            turnHandler(false)
        }
        
        self.saveInBackgroundWithBlock { (success, error) -> Void in
            if success {
                println("Just saved the turn with active player: \(self.activePlayer.name)")
            } else {
                println("Something happened: \(error.userInfo)")
            }
        }
    }
    
    func rematch() {
        player1.shotsTaken = [Int]()
        player1.targetsHit = [Int]()
        player1.activeHits = [Int]()
        
        player2.shotsTaken = [Int]()
        player2.targetsHit = [Int]()
        player2.activeHits = [Int]()
    }
    
    // MARK: - Parse
    class func parseClassName() -> String! {
        return "Battle"
    }
    
    override class func load() {
        self.registerSubclass()
    }
    
}