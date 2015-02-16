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
    var squares = [Int]()
    
    init(size: BoatSize, squares: [Int]?) {
        self.size = size
        
        // We're only using generated boats, just calling it from inside initializer for convenience
        self.squares = squares ?? [Int]()
        self.defineRandomBoatSquares()
    }
    
    // MARK: - Boat colors
    func color() -> UIColor {
        let boatColor = UIColor.orangeColor()
        return boatColor.colorWithAlphaComponent(CGFloat(size.rawValue)/5.0)
    }
    // MARK: - Random generating Boat positions
    
    func defineRandomBoatSquares() {
        var boatSquares = [Int]()
        var direction = BoatDirection(rawValue: Int(arc4random_uniform(UInt32(2))))!
        
        populateSquares(direction)
    }
    
    private func normalizeBoatPosition() {
        self.squares = map(self.squares, { $0 - 1 })
    }
    
    private func populateSquares(direction: BoatDirection) {
        if self.size.rawValue > self.squares.count {
            if self.squares.count == 0 {
                self.squares.append(Int(arc4random_uniform(UInt32(100))) + 1)
                return populateSquares(direction)
            }
            
            var normalizedPosition: Int
            var hasEnoughSquares: Bool
            
            if direction == BoatDirection.Horizontal {
                normalizedPosition = self.squares[0] > 10 ? (self.squares[0] % 10 == 0 ? self.size.rawValue : self.squares[0] % 10) : self.squares[0]

                if normalizedPosition > 0 && normalizedPosition < self.size.rawValue {
                    self.squares.append(self.squares.last! + direction.squareOffset())
                } else {
                    self.squares.append(self.squares.last! - direction.squareOffset())
                }
            } else {
                normalizedPosition = self.squares[0] > 10 ? self.squares[0] / 10 : self.squares[0]

                if normalizedPosition > 0 && normalizedPosition > self.size.rawValue {
                    self.squares.append(self.squares.last! - direction.squareOffset())
                } else {
                    self.squares.append(self.squares.last! + direction.squareOffset())
                }
            }
            
            populateSquares(direction)
        } else {
            normalizeBoatPosition()
        }
    }
}
