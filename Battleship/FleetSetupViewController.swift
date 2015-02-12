//
//  FleetSetupViewController.swift
//  Battleship
//
//  Created by Renato Camilio on 2/9/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import UIKit

class FleetSetupViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var fleetCollectionView: UICollectionView!
    var playerFleet = Fleet.generateFleet()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        self.fleetCollectionView.delegate = self
        self.fleetCollectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "startBattle" {
            let newVC = segue.destinationViewController as BattleViewController
            
            // CPU setup
            var CPUFleet = Fleet.generateFleet()
            
            // match the guys!
            var player = Player(ownFleet: self.playerFleet, opponentFleet: CPUFleet)
            var CPU = Player(ownFleet: CPUFleet, opponentFleet: self.playerFleet)
            
            // prepare to Battle!
            var newBattle = Battle(player: player, opponent: CPU)
            newVC.battle = newBattle
        }
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
        
        var possibleBoat: Boat? = self.playerFleet.boats.filter { (boat: Boat) -> Bool in
            return contains(boat.squares, indexPath.item)
        }.first
        
        cell.boat = possibleBoat
        
        return cell
    }
    
    @IBAction func newFleetWasPressed(sender: AnyObject) {
        self.playerFleet = Fleet.generateFleet()
        self.fleetCollectionView.reloadData()
    }

}
