//
//  Character.swift
//  first-rpg-game
//
//  Created by Peter Zaporowski on 03.01.2017.
//  Copyright © 2017 Peter Zaporowski. All rights reserved.
//

import Foundation


class Character {
    
    private var _hp: Int = 100
    private var _attackPwr: Int = 10
    
    
    var attackPwr: Int {
        get{
            return _attackPwr
        }
    }
    
    var hp: Int {
        get{
            return _hp
        }
    }
    
    var isAlive: Bool {
        get{
            if hp <= 0 {
                return false
            }
            else{
                return true
            }
        }
    }
    
    init(startingHp: Int, attackPwr: Int) {
        self._hp = startingHp // _hp refers to global variable, startingHp is just for this instance
        self._attackPwr = attackPwr
    }
    
    func attemptAttack(attackPwr: Int) -> Bool {
        self._hp -= attackPwr
        return true
    }
    
}