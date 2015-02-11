//
//  FleetSquareCollectionViewCell.swift
//  Battleship
//
//  Created by Renato Camilio on 2/9/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import UIKit

class FleetSquareCollectionViewCell: UICollectionViewCell {
    var boat: Boat? {
        get {
            return self.boat
        }
        set {
            self.backgroundColor = newValue != nil ? newValue?.color : UIColor.whiteColor()
        }
    }
    var containsShip: Bool = false
    var isChecked: Bool = false
}
