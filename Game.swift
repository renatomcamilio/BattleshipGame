//
//  Game.swift
//  Battleship
//
//  Created by Renato Camilio on 2/9/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import UIKit

class Game {
    let players: [Player]
    var activePlayer: Player?
    var winner: Player?
    var round = 0
    
    init(players: [Player]) {
        self.players = players
    }
}
