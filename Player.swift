//
//  Player.swift
//  Battleship
//
//  Created by Renato Camilio on 2/9/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//
import UIKit

class Player {
    var ownFleet: Fleet
    var opponentFleet: Fleet?
    var shotsTaken = [Int]()
    var targetsHit = [Int]()
    var activeHits: [Int] = [Int]() // belongs to the targetgenerator
    var restOfBoatCouldBeAt: [Int]? // belong to the targetgenerator
    
    init(ownFleet: Fleet, opponentFleet: Fleet?) {
        self.ownFleet = ownFleet
        self.opponentFleet = opponentFleet
    }

}

extension Player {
    
    func possibleTargets(shotsTaken: [Int]) -> [Int] {

        
        var boardArray = [Int](count: 100, repeatedValue: 0)
        var possibleTargets = [Int]()
        for (i, value) in enumerate (boardArray) {
            if !contains(shotsTaken, i) {
                possibleTargets.append(i)
            }
        }
        return possibleTargets
    }
    
    func takeRandomShot(possibleTargets: [Int]) -> Int {
        var randomTarget = Int(arc4random_uniform(UInt32(possibleTargets.count)))
        return possibleTargets[randomTarget]
    }
    
    
    func calculateBestTargetToShootAt() -> Int {
        var board = [Int](count: 100, repeatedValue: 0)

        // if there are no active Hits, then shoot at random target
        if self.activeHits.count == 0 {
            var targetArray = possibleTargets(self.shotsTaken)
            return takeRandomShot(targetArray)
            
        } else {
            // calculate valid positions if there is an active target
            
            if self.restOfBoatCouldBeAt == nil {
                self.restOfBoatCouldBeAt = [Int]()
            }
            
            if activeHits.count == 1 {
                var cell = self.activeHits.first!
                
                // Can add item above
                if cell < 90 {
                    self.restOfBoatCouldBeAt!.append(cell + 10)
                }
                // Can add item below
                if cell > 9 {
                    self.restOfBoatCouldBeAt!.append(cell - 10)
                }
                // Can add item to the left
                if cell > 0 && cell < 10 {
                    self.restOfBoatCouldBeAt!.append(cell - 1)
                } else {
                    if cell % 10 > 0 {
                        self.restOfBoatCouldBeAt!.append(cell - 1)
                    }
                }
                // Can add item to the right
                if cell < 9 {
                    self.restOfBoatCouldBeAt!.append(cell + 1)
                } else {
                    if cell % 10 < 9 {
                        self.restOfBoatCouldBeAt!.append(cell + 1)
                    }
                }
            } else if activeHits.count > 1 {
                // calculate valid positions if multiple cells are selected
                self.restOfBoatCouldBeAt!.removeAll(keepCapacity: true)
                // Is position vertical or horizontal?
                var sortedArray = sorted(self.activeHits)
                if sortedArray[1] - sortedArray[0] == 1 { // position is horizontal
                    for cell in self.activeHits {
                        println("horizontal")
                        // Can add item to the left
                        if cell > 0 && cell < 10 {
                            self.restOfBoatCouldBeAt!.append(cell - 1)
                        } else {
                            if cell % 10 > 0 {
                                self.restOfBoatCouldBeAt!.append(cell - 1)
                            }
                        }
                        // Can add item to the right
                        if cell < 9 {
                            self.restOfBoatCouldBeAt!.append(cell + 1)
                        } else {
                            if cell % 10 < 9 {
                                self.restOfBoatCouldBeAt!.append(cell + 1)
                            }
                        }
                    }
                } else { // boat is vertical
                    println("vertical")
                    for cell in self.activeHits {
                        // Can add item above
                        if cell < 90 {
                            self.restOfBoatCouldBeAt!.append(cell + 10)
                        }
                        // Can add item below
                        if cell > 9 {
                            self.restOfBoatCouldBeAt!.append(cell - 10)
                        }
                    }
                }
            }
            // remove duplicates from valid positions
            var unique = [Int]()
            for item in self.restOfBoatCouldBeAt! {
                if !contains(unique, item) {
                    unique.append(item)
                }
            }
            restOfBoatCouldBeAt = unique
            
            // remove shots taken at valid positions
            var onlyValidPositionsLeft = [Int]()
            
            for item in self.restOfBoatCouldBeAt! {
                if !contains(self.shotsTaken, item) {
                    onlyValidPositionsLeft.append(item)
                }
            }
            var targetArray = onlyValidPositionsLeft
            
            // if no valid positions are left, take a random shot and reset active hits to zero
            if targetArray.count == 0 {
                activeHits.removeAll(keepCapacity: true)

                return takeRandomShot(possibleTargets(shotsTaken))
            } else {
                var takeShotAt = targetArray.first
                
                return takeShotAt!
            }
        }
    }
    
}