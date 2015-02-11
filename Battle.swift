//
//  Battle.swift
//  Battleship
//
//  Created by Renato Camilio on 2/10/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//


class Battle {
    let opponent: Player
    let player: Player
    var activePlayer: Player?
    var winner: Player?
    var round = 1
    
    init(player: Player, opponent: Player) {
        self.player = player
        self.opponent = opponent
    }
    
    
    func startBattle() {
        
    }
    

    //Step 2: Player takes turn
        // Update shots taken
        // If hit, update results in HUD
        // check if game has ended
        // else update round counter and repeat function
        
    
    func playerSelectedCell(#indexPathItem: Int, battleVC: BattleViewController) {
        // update shots taken
        activePlayer?.shotsTaken.append(indexPathItem)
        // was it a hit?
        var possibleBoat = somethingWasHit(indexPathItem)
        if let boatThatWasHit = possibleBoat {
            // check if boat was destroyed
            activePlayer?.targetsHit.append(indexPathItem)
            if boatWasDestroyed(boatThatWasHit) {
                // Boat destroyed do something
                println("My \(boatThatWasHit.size) was destroyd!")
                
                if gameHasEnded() {
                    println("Active Player won!")
                    
                    self.winner = activePlayer
                }
            } else {
                // Boat hit but not destroyed do something
            }
        }
        // water was hit.  Do something
    }
    
    //Step 3: Refresh GUI with next players turn
    
    //MARK helper methods
    
    func somethingWasHit(indexPathItem: Int) -> (Boat?) {
        for boat in opponent.ownFleet.boats {
            for square in boat.squares {
                if indexPathItem == square {
                    return (boat)
                }
            }
        }
        return (nil)
    }
    
    func boatWasDestroyed(boat:Boat) -> Bool {
        var hits = [Int]()
        for boat in self.opponent.ownFleet.boats {
            for square in boat.squares {
                if contains(self.activePlayer!.shotsTaken, square) {
                hits.append(square)
                }
            }
            if hits.count == boat.squares.count {
                return true
            }
        }
        return false
    }
    
    func gameHasEnded() -> Bool {
        return activePlayer?.targetsHit.count == activePlayer?.opponentFleet.takenPositions.count
    }
    
}
