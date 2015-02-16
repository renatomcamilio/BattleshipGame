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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        var possibleBoat: Boat?
        
  
        
        if contains(opponentShots, index) {// opponent own fleet logic (with hitBoat and miss)
            if contains(player?.ownFleet.takenPositions ?? [Int](), index) {// and if the player has placed any boats in here
                cell.state = .HitBoat // then opponent has shot a boat!
            } else {// else it was a miss, or, water
                cell.state = .Miss
            }
        } else {// player own fleet logic (with boat colors)
            if contains(player?.ownFleet.takenPositions ?? [Int](), index) && mode == .Player {// if it's the player fleet, show the boat colors
                cell.state = .Boat
                possibleBoat = player?.ownFleet.boats.filter { (boat: Boat) -> Bool in
                    return contains(boat.squares, index)
                }.first
                cell.backgroundColor = possibleBoat?.color()
            } else {
                cell.state = .Empty
            }
        }
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let opponentShots = opponent?.shotsTaken ?? [Int]()
        
        // if shotsTaken contains index, ignore it
        if mode == .Player || contains(opponentShots, indexPath.item) {
            return
        }
        
        self.battleDelegate?.playerSelectedCell(indexPath)
        
        collectionView.reloadItemsAtIndexPaths([indexPath])
    }
    
    func refreshView() {
        collectionView?.reloadData()
    }
}
