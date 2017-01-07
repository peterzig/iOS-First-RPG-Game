//
//  DevilKulik.swift
//  first-rpg-game
//
//  Created by Peter Zaporowski on 03.01.2017.
//  Copyright © 2017 Peter Zaporowski. All rights reserved.
//

import Foundation

class DevilKulik: Enemy {
    
    override var loot: [String] {
        return ["Vodka", "Kulik's Virginity Ring", "Raw Chicken Meat"]
    }
    
    override var type: String{
        return "Devil Kulik"
    }
}