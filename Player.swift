//
//  Player.swift
//  Battleship
//
//  Created by Renato Camilio on 2/9/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//


class Player {
    var ownFleet: Fleet
    var opponentFleet: Fleet?
    var shotsTaken = [Int]()
    var targetsHit = [Int]()
    
    init(ownFleet: Fleet, opponentFleet: Fleet?) {
        self.ownFleet = ownFleet
        self.opponentFleet = opponentFleet
    }
    
    func takeShot(index: Int) {
        shotsTaken.append(index)
    }
}

