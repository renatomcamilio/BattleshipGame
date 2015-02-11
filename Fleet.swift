//
//  Fleet.swift
//  Battleship
//
//  Created by Renato Camilio on 2/9/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import UIKit


class Fleet {
    let boats: [Boat]
    var collectionView: UICollectionView?
    
    init(boats: [Boat]) {
        self.boats = boats
    }
    
    init(boats: [Boat], collectionView: UICollectionView) {
        self.boats = boats
        self.collectionView = collectionView
    }
}
