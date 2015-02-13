//
//  Player.swift
//  Battleship
//
//  Created by Renato Camilio on 2/9/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//
import UIKit

class Player {
    let name: String
    var ownFleet: Fleet
    var opponentFleet: Fleet?
    var shotsTaken = [Int]()
    var targetsHit = [Int]()
    var activeHits: [Int] = [Int]() // belongs to the playerAI
    var restOfBoatCouldBeAt: [Int]? // belongs to the playerAI
    
    init(ownFleet: Fleet, name: String, opponentFleet: Fleet?) {
        self.name = name
        self.ownFleet = ownFleet
        self.opponentFleet = opponentFleet
    }

}
