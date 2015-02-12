//
//  FleetSquareCollectionViewCell.swift
//  Battleship
//
//  Created by Renato Camilio on 2/9/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import UIKit

enum FleetSquareState {
    case Boat
    case HitBoat
    case Miss
    case Empty
}


class FleetSquareCollectionViewCell: UICollectionViewCell {
//    var boat: Boat? {
//        get {
//            return self.boat
//        }
//        set {
//            self.backgroundColor = newValue != nil ? newValue?.color : UIColor.whiteColor()
//        }
//    }
    
    var state: FleetSquareState = .Empty {
        didSet {
            switch (state) {
            case .HitBoat:
                self.backgroundColor = UIColor.redColor()
            case .Boat:
                self.backgroundColor = UIColor.orangeColor() // warning us that we didn't override this in the corntroller
            case .Miss:
                self.backgroundColor = UIColor.cyanColor()
            case .Empty:
                self.backgroundColor = UIColor.whiteColor()
            }
        }
    }
}
