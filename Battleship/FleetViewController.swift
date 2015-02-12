//
//  FleetViewController.swift
//  Battleship
//
//  Created by Renato Camilio on 2/11/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import UIKit


enum FleetDisplayMode {
    case Player
    case Opponent
}

class FleetViewController: UICollectionViewController {
    
    var player: Player?
    var opponent: Player?
    var mode = FleetDisplayMode.Player
    
    var battleDelegate: BattleViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ok, if there's no battleDelegate, please, generate a fleet for me
        // if the player press the new fleet, the generate a new one
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("fleetSquare", forIndexPath: indexPath) as FleetSquareCollectionViewCell
        let index = indexPath.item
        
        let opponentShots = opponent?.shotsTaken ?? [Int]()// Both player and opponent fleet should be aware of its opponent shots, so you prepare your fleet based on those shots (if any)
        
        if contains(opponentShots, index) {// opponent own fleet logic (with hitBoat and miss)
            if contains(player?.ownFleet.takenPositions ?? [Int](), index) {// and if the player has placed any boats in here
                cell.state = .HitBoat // then opponent has shot a boat!
            } else {// else it was a miss, or, water
                cell.state = .Miss
            }
        } else {// player own fleet logic (with boat colors)
            if contains(player?.ownFleet.takenPositions ?? [Int](), index) && mode == .Player {// if it's the player fleet, show the boat colors
                cell.state = .Boat
                // boat color override here!
            } else {
                cell.state = .Empty
            }
        }
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if mode == .Player {
            return
        }
        
        self.battleDelegate?.playerSelectedCell(indexPath)
        
        collectionView.reloadItemsAtIndexPaths([indexPath])
    }
    
    func refreshView() {
        collectionView?.reloadData()
    }
}
