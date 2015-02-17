//
//  Fleet.swift
//  Battleship
//
//  Created by Renato Camilio on 2/9/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import UIKit


class Fleet: PFObject, PFSubclassing {
    var boats: [Boat]
    @NSManaged var takenPositions: [Int]
    
    init(boats: [Boat]) {
        self.boats = boats
        
        super.init()
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
        
        let aircraftCarrier = Boat(size: BoatSize.AircraftCarrier, squares: nil)
        takenPositions += aircraftCarrier.squares
        
        let battleship = Boat(size: BoatSize.Battleship, squares: nil)
        takenPositions += battleship.squares
        
        let cruiser = Boat(size: BoatSize.Cruiser, squares: nil)
        takenPositions += cruiser.squares
        
        let destroyer = Boat(size: BoatSize.Destroyer, squares: nil)
        takenPositions += destroyer.squares
        
        let destroyer2 = Boat(size: BoatSize.Destroyer, squares: nil)
        takenPositions += destroyer2.squares
        
        let submarine = Boat(size: BoatSize.Submarine, squares: nil)
        takenPositions += submarine.squares
        
        let submarine2 = Boat(size: BoatSize.Submarine, squares: nil)
        takenPositions += submarine2.squares
        
        let fleet = Fleet(boats: [aircraftCarrier, battleship, cruiser, destroyer, destroyer2, submarine, submarine2])
        fleet.takenPositions = takenPositions
        
        if itemsAreUniqueAndValid(takenPositions) { // if fleet is unique, return it
            return fleet
        } else { // else, keep generating it until it's unique
            return generateFleet()
        }
    }
    
    // MARK: - Parse
    class func parseClassName() -> String! {
        return "Fleet"
    }
    
    override class func load() {
        self.registerSubclass()
    }
}
