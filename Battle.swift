//
//  Battle.swift
//  Battleship
//
//  Created by Renato Camilio on 2/10/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//
import UIKit

class Battle {
    
    let opponent: Player
    let player: Player
    var activePlayer: Player?
    var winner: Player?
    var round = 1
    var turn = 1
    
    init(player: Player, opponent: Player) {
        self.player = player
        self.opponent = opponent
        self.activePlayer = player
    }

    func gameHasWinner() -> Bool {
        var isThereAWinner = activePlayer?.targetsHit.count == activePlayer?.opponentFleet?.takenPositions.count
        
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
        
        // Update active player
        if self.activePlayer === self.player {
            self.activePlayer = self.opponent
            turnHandler(true)
        } else {
            self.activePlayer = self.player
            turnHandler(true)
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
    
    func resetBattle() {
        opponent.shotsTaken = [Int]()
        opponent.targetsHit = [Int]()
        opponent.activeHits = [Int]()
        
        player.shotsTaken = [Int]()
        player.targetsHit = [Int]()
        player.activeHits = [Int]()
    }
    
}
