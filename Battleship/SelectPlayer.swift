//
//  SelectPlayer.swift
//  Battleship
//
//  Created by Michael Reining on 2/16/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import UIKit

class SelectPlayer: UITableViewController {
    var users = [PFUser]()

    override func viewDidLoad() {
        var query = PFUser.query()
        var resultsArray = query.findObjects()
        for user in resultsArray {
            users.append(user as PFUser)
        }
        println(users.count)
        
        for (index, user) in enumerate(users) {
            if user.objectId == PFUser.currentUser().objectId {
                users.removeAtIndex(index)
            }
        }
        
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PlayerCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = users[indexPath.row].username
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedUser = users[indexPath.row].username
        // With destructive RED button
        
        let alertController = UIAlertController(title: "Selected Player", message: "Would you like to start a game with \(selectedUser)?", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            println(action)
        }
        alertController.addAction(cancelAction)
        
        let destroyAction = UIAlertAction(title: "Game on!", style: .Default) { (action) in
            println(action)
        }
        alertController.addAction(destroyAction)
        
        self.presentViewController(alertController, animated: true) {
            // ...
        }
    }
    
    
    
    
}
