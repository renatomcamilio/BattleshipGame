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
    @IBOutlet weak var winnerStatsLabel: UILabel!
    @IBOutlet weak var loserLabel: UILabel!
    @IBOutlet weak var loserStatsLabel: UILabel!
    var battleEndDelegate: BattleViewController? // Later on create a protocol to situations like these
    
    var battle: Battle?
    var winner: Player?
    var loser: Player?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        battle = battleEndDelegate!.battle
        winner = battle!.winner!
        
        // the loser is set based on the winner.
        loser = battle?.winner! === battle?.opponent ? battle?.player : battle?.opponent
        
        winnerLabel.text = "\(winner!.name) wins!"
        winnerStatsLabel.text = playerStats(winner!)
        
        loserLabel.text = "\(loser!.name)"
        loserStatsLabel.text = playerStats(loser!)
    }
    
    func playerStats(player: Player) -> String {
        var hits = "Hits: \(player.targetsHit.count)/\(battle!.round)"
        var accuracy = "Accuracy: \(Int(Double(player.targetsHit.count) / Double(battle!.round) * 100))%"
        
        return join("\n", [hits, accuracy])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "rematchSegue" || segue.identifier == "exitSegue" {
            battle?.resetBattle()
        }
    }
}
