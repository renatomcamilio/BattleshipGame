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
    
}
