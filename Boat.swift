//
//  Boat.swift
//  Battleship
//
//  Created by Renato Camilio on 2/9/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import UIKit

//(Aircraft carrier: 5), (Battleship: 4), (Cruiser: 3), (Destroyer: 2), (Submarine: 1)
enum BoatSize: Int {
    case Submarine = 1
    case Destroyer, Cruiser, Battleship, AircraftCarrier
}

class Boat {
    let size: BoatSize
    let type: String
    let color: UIColor
    let squares: [Square]
    
    init(size: BoatSize, type: String, squares: [Square], color: UIColor) {
        self.size = size
        self.type = type
        self.squares = squares
        self.color = color
    }
}
