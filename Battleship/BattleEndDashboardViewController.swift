//
//  BattleEndDashboardViewController.swift
//  Battleship
//
//  Created by Renato Camilio on 2/12/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import UIKit

class BattleEndDashboardViewController: UIViewController {
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var playerStatsLabel: UILabel!
    var battleEndDelegate: BattleViewController? // Later on create a protocol to situations like these
    
    var battle: Battle?
    var winner: Player?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        battle = battleEndDelegate!.battle
        winner = battle!.winner!
        winnerLabel.text = "\(winner!.name) wins!"
        playerStatsLabel.text = playerStats()
    }
    
    func playerStats() -> String {
        var hits = "Hits: \(winner!.targetsHit.count)/\(battle!.round)"
        var accuracy = "Accuracy: \(Int(Double(winner!.targetsHit.count) / Double(battle!.round) * 100))%"
        
        return join("\n", [hits, accuracy])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func exitWasPressed(sender: AnyObject) {
        // tell the navigationViewController to go back to Initial Screen
        (battleEndDelegate?.presentingViewController as UINavigationController).popToRootViewControllerAnimated(false)

        // and dismiss all the presenting modals, so the player can see the initial screen
        self.battleEndDelegate?.presentingViewController?.dismissViewControllerAnimated(false, nil)
        self.dismissViewControllerAnimated(false, nil)
    }
    
    @IBAction func rematchWasPressed(sender: AnyObject) {
        // reset the game so it'll clean the state of both player 1 and player 2 (CPU)
        battle?.resetBattle()
        
        // dismiss the battle game board and also the battle end dashboard, back to Fleet setup
        self.battleEndDelegate?.presentingViewController?.dismissViewControllerAnimated(false, nil)
        self.dismissViewControllerAnimated(false, nil)
    }
}
