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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes

        // Do any additional setup after loading the view.
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
        
        if let shots = opponent?.shotsTaken {
            
            if contains(shots, index) {
                if contains(player?.ownFleet.takenPositions ?? [Int](), index) {
                    cell.state = .HitBoat
                } else {
                    cell.state = .Miss
                }
            } else {
                if contains(player?.ownFleet.takenPositions ?? [Int](), index) {
                    if mode == .Player {
                        cell.state = .Boat
                        //if (boat type == ??)
                         // chose a color
                    } else {
                        cell.state = .Empty
                    }
                } else {
                    cell.state = .Empty
                }
            }
        } else {
        
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
    

}
