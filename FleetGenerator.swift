//
//  FleetGenerator.swift
//  BattleShip
//
//  Created by Michael Reining on 2/8/15.
//  Copyright (c) 2015 Mike Reining. All rights reserved.
//

import Foundation

class FleetGenerator {
    var takenPositions = [Int]()
    var newPositions = [Int]()
    var aircraftCarrierPositions = [Int]()
    var battleshipPositions = [Int]()
    var cruizerPositions = [Int]()
    var destroyer1Positions = [Int]()
    var destroyer2Positions = [Int]()
    var submarine1Position = [Int]()
    var submarine2Position = [Int]()
    
    //MARK: Functions to generate random position for each boat
    // Step 1 Setup aircraft carrier on grid
    func generateRandomPositionForAircraftCarrier() {
        var boatSize = 5
        var boatPosition1 = Int(arc4random_uniform(UInt32(100)))
        var boatPosition2: Int
        var boatPosition3: Int
        var boatPosition4: Int
        var boatPosition5: Int
        var verticalOrHorizontalPosition = Int(arc4random_uniform(UInt32(2)))
        if verticalOrHorizontalPosition == 0 {
            // vertical.  Can boat be added downwards?
            if boatPosition1 < 61 { // can position board downwards
                boatPosition2 = boatPosition1 + 10
                boatPosition3 = boatPosition1 + 20
                boatPosition4 = boatPosition1 + 30
                boatPosition5 = boatPosition1 + 40
            } else { // position boat upwards
                boatPosition2 = boatPosition1 - 10
                boatPosition3 = boatPosition1 - 20
                boatPosition4 = boatPosition1 - 30
                boatPosition5 = boatPosition1 - 40
            }
        } else {
            // horizontal.  Can boat be positioned forward?
            var testPosition = boatPosition1
            if boatPosition1 > 10 {
                testPosition = boatPosition1 % 10
            }
            if testPosition < 6 { // can position boat forward
                boatPosition2 = boatPosition1 + 1
                boatPosition3 = boatPosition1 + 2
                boatPosition4 = boatPosition1 + 3
                boatPosition5 = boatPosition1 + 4
            } else { // position boat backwards
                boatPosition2 = boatPosition1 - 1
                boatPosition3 = boatPosition1 - 2
                boatPosition4 = boatPosition1 - 3
                boatPosition5 = boatPosition1 - 4
            }
        }
        // setup new boat positions
        var newBoatPositions = [Int]()
        newBoatPositions.append(boatPosition1)
        newBoatPositions.append(boatPosition2)
        newBoatPositions.append(boatPosition3)
        newBoatPositions.append(boatPosition4)
        newBoatPositions.append(boatPosition5)
        
        aircraftCarrierPositions = newBoatPositions
        takenPositions += aircraftCarrierPositions
    }
    
    // Step 2: Setup battleshipon on grid
    
    func generateRandomPositionForBattleship() {
        var boatSize = 4
        var boatPosition1 = Int(arc4random_uniform(UInt32(100)))
        var boatPosition2: Int
        var boatPosition3: Int
        var boatPosition4: Int
        var verticalOrHorizontalPosition = Int(arc4random_uniform(UInt32(2)))
        if verticalOrHorizontalPosition == 0 {
            // vertical.  Can boat be added downwards?
            if boatPosition1 < 71 { // can position board downwards
                boatPosition2 = boatPosition1 + 10
                boatPosition3 = boatPosition1 + 20
                boatPosition4 = boatPosition1 + 30
            } else { // position boat upwards
                boatPosition2 = boatPosition1 - 10
                boatPosition3 = boatPosition1 - 20
                boatPosition4 = boatPosition1 - 30
            }
        } else {
            // horizontal.  Can boat be positioned forward?
            var testPosition = boatPosition1
            if boatPosition1 > 10 {
                testPosition = boatPosition1 % 10
            }
            if testPosition < 7 { // can position boat forward
                boatPosition2 = boatPosition1 + 1
                boatPosition3 = boatPosition1 + 2
                boatPosition4 = boatPosition1 + 3
            } else { // position boat backwards
                boatPosition2 = boatPosition1 - 1
                boatPosition3 = boatPosition1 - 2
                boatPosition4 = boatPosition1 - 3
            }
        }
        
        // setup new boat positions
        var newBoatPositions = [Int]()
        newBoatPositions.append(boatPosition1)
        newBoatPositions.append(boatPosition2)
        newBoatPositions.append(boatPosition3)
        newBoatPositions.append(boatPosition4)
        
        battleshipPositions = newBoatPositions
        takenPositions += battleshipPositions
    }
    
    // Step 3: Put cruiser on grid
    
    func generateRandomPositionForCruizer() {
        var boatSize = 3
        var boatPosition1 = Int(arc4random_uniform(UInt32(100)))
        var boatPosition2: Int
        var boatPosition3: Int
        var verticalOrHorizontalPosition = Int(arc4random_uniform(UInt32(2)))
        if verticalOrHorizontalPosition == 0 {
            // vertical.  Can boat be added downwards?
            if boatPosition1 < 81 { // can position board downwards
                boatPosition2 = boatPosition1 + 10
                boatPosition3 = boatPosition1 + 20
            } else { // position boat upwards
                boatPosition2 = boatPosition1 - 10
                boatPosition3 = boatPosition1 - 20
            }
        } else {
            // horizontal.  Can boat be positioned forward?
            var testPosition = boatPosition1
            if boatPosition1 > 10 {
                testPosition = boatPosition1 % 10
            }
            if testPosition < 8 { // can position boat forward
                boatPosition2 = boatPosition1 + 1
                boatPosition3 = boatPosition1 + 2
            } else { // position boat backwards
                boatPosition2 = boatPosition1 - 1
                boatPosition3 = boatPosition1 - 2
            }
        }
        
        // setup new boat positions
        var newBoatPositions = [Int]()
        newBoatPositions.append(boatPosition1)
        newBoatPositions.append(boatPosition2)
        newBoatPositions.append(boatPosition3)
        
        cruizerPositions = newBoatPositions
        takenPositions += cruizerPositions
        
    }
    
    // Step 4: Put first destroyer on map
    
    func generateRandomPositionForDestroyer1() {
        var boatSize = 2
        var boatPosition1 = Int(arc4random_uniform(UInt32(100)))
        var boatPosition2: Int
        var verticalOrHorizontalPosition = Int(arc4random_uniform(UInt32(2)))
        if verticalOrHorizontalPosition == 0 {
            // vertical.  Can boat be added downwards?
            if boatPosition1 < 91 { // can position board downwards
                boatPosition2 = boatPosition1 + 10
            } else { // position boat upwards
                boatPosition2 = boatPosition1 - 10
            }
        } else {
            // horizontal.  Can boat be positioned forward?
            var testPosition = boatPosition1
            if boatPosition1 > 10 {
                testPosition = boatPosition1 % 10
            }
            if testPosition < 9 { // can position boat forward
                boatPosition2 = boatPosition1 + 1
            } else { // position boat backwards
                boatPosition2 = boatPosition1 - 1
            }
        }
        
        // setup new boat positions
        var newBoatPositions = [Int]()
        newBoatPositions.append(boatPosition1)
        newBoatPositions.append(boatPosition2)
        
        destroyer1Positions = newBoatPositions
        takenPositions += destroyer1Positions
    }
    
    // Step 5: Put second destroyer on map
    
    func generateRandomPositionForDestroyer2() {
        var boatSize = 2
        var boatPosition1 = Int(arc4random_uniform(UInt32(100)))
        var boatPosition2: Int
        var verticalOrHorizontalPosition = Int(arc4random_uniform(UInt32(2)))
        if verticalOrHorizontalPosition == 0 {
            // vertical.  Can boat be added downwards?
            if boatPosition1 < 91 { // can position board downwards
                boatPosition2 = boatPosition1 + 10
            } else { // position boat upwards
                boatPosition2 = boatPosition1 - 10
            }
        } else {
            // horizontal.  Can boat be positioned forward?
            var testPosition = boatPosition1
            if boatPosition1 > 10 {
                testPosition = boatPosition1 % 10
            }
            if testPosition < 9 { // can position boat forward
                boatPosition2 = boatPosition1 + 1
            } else { // position boat backwards
                boatPosition2 = boatPosition1 - 1
            }
        }
        
        // setup new boat positions
        var newBoatPositions = [Int]()
        newBoatPositions.append(boatPosition1)
        newBoatPositions.append(boatPosition2)
        
        destroyer2Positions = newBoatPositions
        takenPositions += destroyer2Positions
        
    }
    
    // Step 6: Put submarine on map
    
    func generateRandomPositionForSubmarine1() {
        var boatSize = 1
        var boatPosition1 = Int(arc4random_uniform(UInt32(100)))
        
        // setup new boat positions
        var newBoatPositions = [Int]()
        newBoatPositions.append(boatPosition1)
        
        submarine1Position = newBoatPositions
        takenPositions += submarine1Position
        
    }
    
    // Step 7: Put submarine 2 on map
    
    func generateRandomPositionForSubmarine2() {
        var boatSize = 1
        var boatPosition1 = Int(arc4random_uniform(UInt32(100)))
        
        // setup new boat positions
        var newBoatPositions = [Int]()
        newBoatPositions.append(boatPosition1)
        
        submarine2Position = newBoatPositions
        takenPositions += submarine2Position
        
    }
    
    //MARK: Fleet Generator Logic
    // generate fleet with one function
    func generateFleet() {
        generateRandomPositionForAircraftCarrier()
        generateRandomPositionForBattleship()
        generateRandomPositionForCruizer()
        generateRandomPositionForDestroyer1()
        generateRandomPositionForDestroyer2()
        generateRandomPositionForSubmarine1()
        generateRandomPositionForSubmarine2()
    }
    
    // test it boats are on unique tiles
    
    func itemsAreUnique(source: [Int]) -> Bool {
        
        var unique = [Int]()
        for item in source {
            if !contains(unique, item) {
                unique.append(item)
            }
        }
        if source.count == unique.count {
            println("all items are unique")
            return true
        } else {
            aircraftCarrierPositions.removeAll(keepCapacity: true)
            battleshipPositions.removeAll(keepCapacity: true)
            cruizerPositions.removeAll(keepCapacity: true)
            destroyer1Positions.removeAll(keepCapacity: true)
            destroyer2Positions.removeAll(keepCapacity: true)
            submarine1Position.removeAll(keepCapacity: true)
            submarine2Position.removeAll(keepCapacity: true)
            takenPositions.removeAll(keepCapacity: true)
            println("initial array contains duplicates")
            return false
        }
    }
    
    func generateUniqueFleet() {
        generateFleet()
        while itemsAreUnique(takenPositions) != true { // if fleet is not unique, redo
            generateFleet()
        }
    }
    
}

