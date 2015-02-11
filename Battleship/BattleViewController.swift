//
//  BattleViewController.swift
//  Battleship
//
//  Created by Renato Camilio on 2/10/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var opponentFleetCollectionView: UICollectionView!
    var battle: Battle?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.opponentFleetCollectionView.delegate = self
        self.opponentFleetCollectionView.dataSource = self
        
        self.battle?.activePlayer = self.battle?.player
        
        self.updateHUD()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateHUD() {
        self.roundLabel.text = "Round: \(self.battle?.round as Int!)"
    }

    // MARK: - Fleet CollectionView DataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    // MARK: - Fleet CollectionView Delegate
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("fleetSquare", forIndexPath: indexPath) as FleetSquareCollectionViewCell
        
        cell.boat = nil
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var cell = self.opponentFleetCollectionView.cellForItemAtIndexPath(indexPath) as FleetSquareCollectionViewCell
        var possibleBoat: Boat? = self.battle?.opponent.ownFleet.boats.filter { (boat: Boat) -> Bool in
            return contains(boat.squares, indexPath.item)
        }.first
        
        if let boat = possibleBoat {
            cell.boat = boat
        } else {
            cell.backgroundColor = UIColor.cyanColor()
        }
        
        self.battle?.playerSelectedCell(indexPathItem: indexPath.item, battleVC: self)
    }
    
    // MARK: - Navigation
    @IBAction func giveUpWasPressed(sender: AnyObject) {
        // We should return the player to the initial screen
        // maybe define the opponent as winner, because the player is giving up
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

}
