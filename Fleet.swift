//
//  Fleet.swift
//  Battleship
//
//  Created by Renato Camilio on 2/9/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import UIKit


class Fleet {
    var boats: [Boat]
    var takenPositions = [Int]()
    
    init(boats: [Boat]) {
        self.boats = boats
    }
    
    // MARK: - Fleet Generator
    class func generateFleet() -> Fleet {
        func itemsAreUniqueAndValid(source: [Int]) -> Bool {
            var unique = [Int]()
            for item in source {
                if !contains(unique, item) && item >= 0 && item < 100 {
                    unique.append(item)
                }
            }
            
            var validAndUnique = source.count == unique.count
            if !validAndUnique {
                println("Invalid Fleet. Regenerating now...")
            }
            
            return validAndUnique
        }
        
        var takenPositions = [Int]()
        
        let aircraftCarrier = Boat(size: BoatSize.AircraftCarrier, squares: nil, color: UIColor.brownColor())
        aircraftCarrier.defineRandomBoatSquares()
        takenPositions += aircraftCarrier.squares
        
        let battleship = Boat(size: BoatSize.Battleship, squares: nil, color: UIColor.blueColor())
        battleship.defineRandomBoatSquares()
        takenPositions += battleship.squares
        
        let cruiser = Boat(size: BoatSize.Cruiser, squares: nil, color: UIColor.redColor())
        cruiser.defineRandomBoatSquares()
        takenPositions += cruiser.squares
        
        var destroyer = Boat(size: BoatSize.Destroyer, squares: nil, color: UIColor.purpleColor())
        destroyer.defineRandomBoatSquares()
        takenPositions += destroyer.squares
        
        var destroyer2 = Boat(size: BoatSize.Destroyer, squares: nil, color: UIColor.purpleColor())
        destroyer2.defineRandomBoatSquares()
        takenPositions += destroyer2.squares
        
        var submarine = Boat(size: BoatSize.Submarine, squares: nil, color: UIColor.grayColor())
        submarine.defineRandomBoatSquares()
        takenPositions += submarine.squares
        
        var submarine2 = Boat(size: BoatSize.Submarine, squares: nil, color: UIColor.grayColor())
        submarine2.defineRandomBoatSquares()
        takenPositions += submarine2.squares
        
        var fleet = Fleet(boats: [aircraftCarrier, battleship, cruiser, destroyer, destroyer2, submarine, submarine2])
        fleet.takenPositions = takenPositions
        
        if itemsAreUniqueAndValid(takenPositions) { // if fleet is unique, return it
            return fleet
        } else { // else, keep generating it until it's unique
            return generateFleet()
        }
    }
}
