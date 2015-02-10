//
//  APIKeys.swift
//  MRBattleShip
//
//  Created by Michael Reining on 2/9/15.
//  Copyright (c) 2015 Mike Reining. All rights reserved.
//

import Foundation

func valueForAPIKey(#keyname:String) -> String {
    let filePath = NSBundle.mainBundle().pathForResource("APIKeys", ofType:"plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    
    let value:String = plist?.objectForKey(keyname) as String
    return value
}

//The code is straightforward and meant to be called like this:
//
//let clientID = valueForAPIKey(keyname:"APIClientID")