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

enum BoatDirection: Int {
    case Vertical, Horizontal
    
    func squareOffset() -> Int {
        switch self {
        case .Vertical:
            return 10
        case .Horizontal:
            return 1
        default:
            return 0 // will never reach
        }
    }
}

class Boat {
    let size: BoatSize
    let color: UIColor
    var squares = [Int]()
    
    init(size: BoatSize, squares: [Int]?, color: UIColor) {
        self.size = size
        self.squares = squares ?? [Int]()
        self.color = color
        
        // We're only using generated boats, just calling it from inside initializer for convenience
        self.defineRandomBoatSquares()
    }
    
    func defineRandomBoatSquares() {
        var boatSquares = [Int]()
        var direction = BoatDirection(rawValue: Int(arc4random_uniform(UInt32(2))))!
        
        populateSquares(direction)
    }
    
    private func populateSquares(direction: BoatDirection) {
        if self.size.rawValue > self.squares.count {
            if self.squares.count == 0 {
                self.squares.append(Int(arc4random_uniform(UInt32(100))))
                return populateSquares(direction)
            }
            
            var normalizedPosition: Int
            var hasEnoughSquares: Bool
            if direction == BoatDirection.Horizontal {
                normalizedPosition = self.squares[0] > 10 ? self.squares[0] % 10 : self.squares[0]

                if normalizedPosition > 0 && normalizedPosition < self.size.rawValue {
                    self.squares.append(self.squares.last! + direction.squareOffset())
                } else {
                    self.squares.append(self.squares.last! - direction.squareOffset())
                }
            } else {
                normalizedPosition = self.squares[0] > 10 ? self.squares[0] / 10 : 0

                if normalizedPosition > 0 && normalizedPosition > self.size.rawValue {
                    self.squares.append(self.squares.last! - direction.squareOffset())
                } else {
                    self.squares.append(self.squares.last! + direction.squareOffset())
                }
            }
            
            
            populateSquares(direction)
        }
    }
}
