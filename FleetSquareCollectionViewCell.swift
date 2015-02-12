//
//  FleetSquareCollectionViewCell.swift
//  Battleship
//
//  Created by Renato Camilio on 2/9/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import UIKit

enum FleetSquareState {
    case Hit
    case Miss
    case Empty
}


class FleetSquareCollectionViewCell: UICollectionViewCell {
    var boat: Boat? {
        get {
            return self.boat
        }
        set {
            self.backgroundColor = newValue != nil ? newValue?.color : UIColor.whiteColor()
        }
    }
    
    var state: FleetSquareState = .Empty {
        didSet {
            switch (state) {
            case .Hit:
                self.backgroundColor = UIColor.blueColor()
            default:
                break
            }
        }
    }
}
