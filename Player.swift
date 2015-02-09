//
//  Player.swift
//  Battleship
//
//  Created by Renato Camilio on 2/9/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import UIKit

class Player {
    let ownFleet: Fleet
    unowned let opponentFleet: Fleet
    var shotsTaken: [Int]?
    
    init(ownFleet: Fleet, opponentFleet: Fleet) {
        self.ownFleet = ownFleet
        self.opponentFleet = opponentFleet
    }
}
