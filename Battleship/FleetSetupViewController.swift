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
    var takenPositions = [Int]()
    var boats = [Boat]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        self.fleetCollectionView.delegate = self
        self.fleetCollectionView.dataSource = self
        
        self.generateUniqueFleet()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Populate the Fleet
    func generateFleet() {
        var aircraftCarrier = Boat(size: BoatSize.AircraftCarrier, squares: nil, color: UIColor.blackColor())
        aircraftCarrier.defineRandomBoatSquares()
        takenPositions += aircraftCarrier.squares
        
        var battleship = Boat(size: BoatSize.Battleship, squares: nil, color: UIColor.greenColor())
        battleship.defineRandomBoatSquares()
        takenPositions += battleship.squares
        
        var cruiser = Boat(size: BoatSize.Cruiser, squares: nil, color: UIColor.redColor())
        cruiser.defineRandomBoatSquares()
        takenPositions += cruiser.squares
        
        var destroyer = Boat(size: BoatSize.Destroyer, squares: nil, color: UIColor.purpleColor())
        destroyer.defineRandomBoatSquares()
        takenPositions += destroyer.squares
        
        var destroyer2 = Boat(size: BoatSize.Destroyer, squares: nil, color: UIColor.purpleColor())
        destroyer2.defineRandomBoatSquares()
        takenPositions += destroyer2.squares
        
        var submarine = Boat(size: BoatSize.Submarine, squares: nil, color: UIColor.grayColor())
        submarine.defineRandomBoatSquares()
        takenPositions += submarine.squares
        
        var submarine2 = Boat(size: BoatSize.Submarine, squares: nil, color: UIColor.grayColor())
        submarine2.defineRandomBoatSquares()
        takenPositions += submarine2.squares
        
        self.boats += [aircraftCarrier, battleship, cruiser, destroyer, destroyer2, submarine, submarine2]
    }
    
    func itemsAreUnique(source: [Int]) -> Bool {
        var unique = [Int]()
        for item in source {
            if !contains(unique, item) {
                unique.append(item)
            }
        }
        if source.count == unique.count {
            println("all items are unique")
            return true
        } else {
            self.takenPositions.removeAll(keepCapacity: true)
            self.boats.removeAll(keepCapacity: true)
            println("initial array contains duplicates")
            return false
        }
    }
    
    func generateUniqueFleet() {
        do {
            generateFleet()
        } while !itemsAreUnique(takenPositions) // if fleet is not unique, redo
        
        self.fleetCollectionView.reloadData()
    }

    // MARK: - Fleet CollectionView DataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("fleetSquare", forIndexPath: indexPath) as FleetSquareCollectionViewCell
        
        var possibleBoat: Boat? = self.boats.filter { (boat: Boat) -> Bool in
            var hasSquare = contains(boat.squares, indexPath.item + 1)
            if hasSquare {
                println("boatSquares: \(boat.squares); normalized: \(boat.squares[0] > 10 ? boat.squares[0] % 10 : boat.squares[0])")
            }
            return hasSquare
        }.first
        
        cell.boat = possibleBoat
        
        return cell
    }
    
    @IBAction func newFleetWasPressed(sender: AnyObject) {
        self.generateUniqueFleet()
    }

}
