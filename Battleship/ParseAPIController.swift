//
//  ParseAPIController.swift
//  Battleship
//
//  Created by Michael Reining on 2/10/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import Foundation

class ParseAPIController {
    var shotsTakenObjectID = "0"
    
    //MARK: Setup Channel on Game Launch
    func setupChanel() {
        //NOTE: The example below includes a lot of DUMMY / hardcoded data.  It just shows
        // that it is easy to add custom fields (columns) when adding a user to a channel.
        // We can then use this custom data to push only the right users
        
        let currentInstallation = PFInstallation.currentInstallation()
        currentInstallation.addUniqueObject("BattleShipGame", forKey: "channels")
//        currentInstallation["user"] = PFUser.currentUser() // Commented out since it will crash game unless user is logged in
        currentInstallation["shotsTakenID"] = "TestShotsTakenID1234"
        currentInstallation["gameID"] = "sampleGameID1234" // should become ID of game.  We should setup a random string
        currentInstallation["userID"] = "sampleUserID1234" // should become Parse User Object ID
        currentInstallation.saveInBackgroundWithBlock{ (success, error) -> Void in
            if success {
                println("channel created")
            }
        }
    }
    
    
    //MARK: Keep track of game
    
    func updateParseWithGameStatus(inout shotsTakenObjectID: String, indexPath: NSIndexPath){
        // Example of how we can easily track any event in Parse
        // NOTE: Instead of tracking it here, I think it will be easier to add this in a
        if shotsTakenObjectID == "0" { // If new game add new row / ID in Parse
            var shotsTaken = PFObject(className:"ShotsTaken")
            shotsTaken.addObject(indexPath.row, forKey: "Shots")
            shotsTaken.saveInBackgroundWithBlock { (success, error) -> Void in
                if success {
                    self.shotsTakenObjectID = shotsTaken.objectId
                    println(shotsTakenObjectID)
                }
            }
        } else { // If continuing game, append data in parse to keep track of game
            var query = PFQuery(className:"ShotsTaken")
            query.getObjectInBackgroundWithId(shotsTakenObjectID) {
                (shotsTaken: PFObject!, error: NSError!) -> Void in
                if error != nil {
                    NSLog("%@", error)
                } else {
                    shotsTaken.addObject(indexPath.row, forKey: "Shots")
                    shotsTaken.saveInBackgroundWithBlock { (success, error) -> Void in
                        if success {
                            println(indexPath.row)
                        }
                    }
                }
            }
        }
    }
    
    //MARK: Send Push Notification
    func sendPushNotification() {
        // CONFIGURE PUSH
        // This sets up a query to only send push notification to a subset of the users
        // As an example, I have added a game ID.  Ideally, we should have a games ID a
        let pushQuery = PFInstallation.query()
        pushQuery.whereKey("channels", equalTo:"BattleShipGame") // Set channel
        pushQuery.whereKey("gameID", equalTo:"sampleGameID1234")
        pushQuery.whereKey("userID", equalTo: "sampleUserID1234")
        
        // SEND PUSH WITH DATA
        // Send data as NSDictionary - this is how we pass the game state / key data along
        // so the receiver has everything they need to continue the game
        let data = [
            "SID" : shotsTakenObjectID,
            "GID" : "sampleGameID1234"
        ]
        let push = PFPush()
        push.setChannel("BattleShipGame")
        push.setMessage("It's your turn!  Go sink some ships!")
        push.setData(data)
        push.sendPushInBackgroundWithBlock{ (success, error) -> Void in
            if success {
                println("push sent successfully")
            }
        }
    }
    
}