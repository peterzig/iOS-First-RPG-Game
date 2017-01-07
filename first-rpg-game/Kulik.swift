//
//  Kulik.swift
//  first-rpg-game
//
//  Created by Peter Zaporowski on 03.01.2017.
//  Copyright © 2017 Peter Zaporowski. All rights reserved.
//

import Foundation

class Kulik: Enemy {
    
    let IMMUNE_MAX = 15
    
    override var loot: [String] {
        return ["Skoda Fabia keys", "Kulik's tooth", "Old pizza"]
    }
    
    override var type: String {
        return "Kulik"
    }
    
    override func attemptAttack(attackPwr: Int) -> Bool {
        if attackPwr >= IMMUNE_MAX {
            return super.attemptAttack(attackPwr)
        } else {
            return false
        }
    }
}