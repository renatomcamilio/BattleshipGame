//
//  Boat.swift
//  Battleship
//
//  Created by Renato Camilio on 2/9/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import UIKit

class Boat {
    let size: Int
    let type: String
    let squares: [Square]
    
    init(size: Int, type: String, squares: [Square]) {
        self.size = size
        self.type = type
        self.squares = squares
    }
}
