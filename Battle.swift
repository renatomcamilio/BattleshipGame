//
//  Battle.swift
//  Battleship
//
//  Created by Renato Camilio on 2/10/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//


class Battle {
    let opponent: Player
    let player: Player
    var activePlayer: Player?
    var winner: Player?
    var round = 0
    
    init(player: Player, opponent: Player) {
        self.player = player
        self.opponent = opponent
    }
}
