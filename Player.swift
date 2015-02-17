//
//  Player.swift
//  Battleship
//
//  Created by Renato Camilio on 2/9/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import Foundation

class Player: PFObject, PFSubclassing {
    
    @NSManaged var name: String
    @NSManaged var pfUser: PFUser
    @NSManaged var ownFleet: Fleet
    @NSManaged var opponentFleet: Fleet?
    @NSManaged var shotsTaken: [Int]
    @NSManaged var targetsHit: [Int]
    
    @NSManaged var activeHits: [Int] // belongs to the playerAI
    @NSManaged var restOfBoatCouldBeAt: [Int]? // belongs to the playerAI
    
    
    init(ownFleet: Fleet, name: String, opponentFleet: Fleet) {
        super.init()
        
        self.name = name
        self.ownFleet = ownFleet
        self.opponentFleet = opponentFleet
        self.targetsHit = [Int]()
        self.shotsTaken = [Int]()
        self.activeHits = [Int]()
    }
    
    // MARK: - Parse
    class func parseClassName() -> String! {
        return "Player"
    }
    
    override class func load() {
        self.registerSubclass()
    }
    
}
