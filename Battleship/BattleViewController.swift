//
//  BattleViewController.swift
//  Battleship
//
//  Created by Renato Camilio on 2/10/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var opponentContainerView: UIView!
    
    var battle: Battle?
    var opponentCollectionView: UICollectionView?
    var playerCollectionView: UICollectionView?
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "playerFleet" {
            let fleetVC = segue.destinationViewController as FleetViewController
            fleetVC.player = battle?.player
            fleetVC.opponent = battle?.opponent
            fleetVC.mode = .Player
            
            self.playerCollectionView = fleetVC.collectionView
            
            fleetVC.battleDelegate = self
        } else if segue.identifier == "opponentFleet" {
            let fleetVC = segue.destinationViewController as FleetViewController
            
            fleetVC.player = battle?.opponent
            fleetVC.opponent = battle?.player
            fleetVC.mode = .Opponent
            
            self.opponentCollectionView = fleetVC.collectionView
            
            fleetVC.battleDelegate = self
        }
    }
    
    
    
    
    func prepareForNextTurn() {
        // TODO;"DOTO" - Mike :)
        
        // Description:
        // Set the "focus" to  activePlayer fleet and "blur" its opponent's fleet
        //
        // My advice is to have one of that "Front UIView" in the opponent's fleet, 
        // and by default, the highlighted fleet is the activePlayer, which means that
        // it doesn't have any layer/view over it
        
        // Setup view for opponentContainerView animation
//        var opponentContainerViewFront = UIView(frame: opponentContainerView.frame)
//        opponentContainerView.addSubview(opponentContainerViewFront)
//        opponentContainerViewFront.backgroundColor = UIColor.blackColor()
//        opponentContainerViewFront.center = CGPointMake(150.0, 150.0)

        
        self.battle!.nextTurn({ isCPUPlayer in
            if isCPUPlayer {
                var shotAt = self.battle!.activePlayer?.calculateBestTargetToShootAt()
                var CPUTarget = NSIndexPath(forItem: shotAt!, inSection: 0)
                
                self.playerSelectedCell(CPUTarget)
                
                self.playerCollectionView?.reloadData()
            }
        })
        animateViews()

        self.roundLabel.text = "Round: \(String(self.battle!.round))"
        self.turnLabel.text = self.battle?.turn == 1 ? "Player turn" : "Opponent turn"
    }
    
    
    
    func playerSelectedCell(indexPath: NSIndexPath) {
        self.battle?.takeShot(indexPath, player: self.battle!.activePlayer!)
        self.prepareForNextTurn()
    }
    
    // MARK: - User interaction
    @IBAction func giveUpWasPressed(sender: AnyObject) {
        // We should return the player to the initial screen
        // maybe define the opponent as winner, because the player is giving up
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func animateViews() {
        
        // Setup view for opponentContainerView animation
        var opponentContainerViewFront = UIView(frame: self.opponentContainerView.frame)
        var opponentContainerViewBack = UIView(frame: self.opponentContainerView.frame)
        self.opponentContainerView.addSubview(opponentContainerViewFront)
        self.opponentContainerView.addSubview(opponentContainerViewBack)
        
        let views = (frontView: opponentContainerViewFront, backView: opponentContainerViewBack)
        let transitionOptions = UIViewAnimationOptions.TransitionFlipFromRight
        UIView.transitionWithView(self.opponentContainerView, duration: 0.5, options: transitionOptions, animations: {
            // remove the front object...
            views.frontView.removeFromSuperview()
            
            // ... and add the other object
            self.opponentContainerView.addSubview(views.backView)
            
            }, completion: { finished in
                // any code entered here will be applied
                // .once the animation has completed
        })

    }

    
}
