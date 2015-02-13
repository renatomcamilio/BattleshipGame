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
    var state: FleetSquareState = .Empty {
        didSet {
            switch (state) {
            case .HitBoat:
                self.backgroundColor = UIColor(red: 248/255, green: 76/255, blue: 23/255, alpha: 1)
            case .Boat:
                self.backgroundColor = UIColor.orangeColor() // warning us that we didn't override this in the corntroller
            case .Miss:
                self.backgroundColor = UIColor(red: 202/255, green: 222/255, blue: 229/255, alpha: 1.0)
            case .Empty:
                self.backgroundColor = UIColor.whiteColor()
            }
        }
    }
}
