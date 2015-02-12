//
//  OpponentCollectionViewController.swift
//  Battleship
//
//  Created by Renato Camilio on 2/11/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import UIKit


class OpponentCollectionViewController: UICollectionViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    let reuseIdentifier = "opponentFleetSquare"
    var battleDelegate: BattleViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
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
        
        //cell.boat = nil
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var cell = self.collectionView?.cellForItemAtIndexPath(indexPath) as FleetSquareCollectionViewCell
        if cell.state == FleetSquareState.Empty {
            self.battleDelegate?.playerSelectedCell(indexPath)
        } else {
            println("Invalid target")
        }
    }

}
