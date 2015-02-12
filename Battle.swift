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

    func gameHasEnded() -> Bool {
        return activePlayer?.targetsHit.count == activePlayer?.opponentFleet?.takenPositions.count
    }
    
    func nextTurn(turnHandler: (Bool)->(Void)) {
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
            turnHandler(false)
        }
    }
    
}
