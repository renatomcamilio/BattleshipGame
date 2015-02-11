//
//  PlayerCollectionViewController.swift
//  Battleship
//
//  Created by Michael Reining on 2/11/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import UIKit

let reuseIdentifier = "playerFleetSquare"

class PlayerCollectionViewController: UICollectionViewController {
    var battle: Battle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return 100
    }

    // MARK: - Fleet CollectionView Delegate
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as FleetSquareCollectionViewCell
        
        var possibleBoat: Boat? = self.battle?.activePlayer?.ownFleet.boats.filter { (boat: Boat) -> Bool in
            return contains(boat.squares, indexPath.item)
            }.first
        
        cell.boat = possibleBoat
        
        return cell
    }

}
