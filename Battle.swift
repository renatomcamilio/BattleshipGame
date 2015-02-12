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
    
    init(player: Player, opponent: Player) {
        self.player = player
        self.opponent = opponent
        self.activePlayer = player
    }
    
    
    func startBattle() {
        
    }

    func gameHasEnded() -> Bool {
        return activePlayer?.targetsHit.count == activePlayer?.opponentFleet.takenPositions.count
    }
    
    
}
