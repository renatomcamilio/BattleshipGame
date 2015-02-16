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
    var crossLabel: UILabel = UILabel()
    
    override func awakeFromNib() {
        crossLabel.font = UIFont.systemFontOfSize(30.0)
        crossLabel.textAlignment = NSTextAlignment.Center
        self.addSubview(crossLabel)
    }
    
    var state: FleetSquareState = .Empty {
        didSet {
            switch (state) {
            case .HitBoat:
                self.backgroundColor = UIColor(red: 248/255, green: 76/255, blue: 23/255, alpha: 1)
                crossLabel.text = "╳"
            case .Boat:
                self.backgroundColor = UIColor.orangeColor() // warning us that we didn't override this in the corntroller
                crossLabel.text = ""
            case .Miss:
                self.backgroundColor = UIColor(red: 202/255, green: 222/255, blue: 229/255, alpha: 1.0)
                crossLabel.text = "╱"
            case .Empty:
                self.backgroundColor = UIColor.whiteColor()
                crossLabel.text = ""
            }
        }
    }
    
    override func layoutSubviews() {
        crossLabel.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: self.frame.height)
        crossLabel.font = UIFont.systemFontOfSize(self.frame.size.width * 1.1)
        
    }
}
