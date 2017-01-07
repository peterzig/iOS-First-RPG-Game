//
//  ViewController.swift
//  first-rpg-game
//
//  Created by Peter Zaporowski on 28.12.2016.
//  Copyright © 2016 Peter Zaporowski. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var printLbl: UILabel!
    @IBOutlet weak var playerHpLbl: UILabel!
    @IBOutlet weak var enemyHpLbl: UILabel!
    
    @IBOutlet weak var enemyImg: UIImageView!
    @IBOutlet weak var playerImg: UIImageView!
    
    @IBOutlet weak var chestBtn: UIButton!
    @IBOutlet weak var enemy2Img: UIImageView!
    @IBOutlet weak var restartBtn: UIButton!
    @IBOutlet weak var attackBtn: UIButton!
    
    var player: Player!
    var enemy: Enemy!

    var chestMsg: String?
    
    var btnSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("sword", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        player = Player(name: "PeterZig23", hp: 110, attackPwr: 20)
        
        generateRandomEnemy()
        
        playerHpLbl.text = "\(player.hp) HP"
        
        
    }
    
    func generateRandomEnemy() {
        let rand = Int(arc4random_uniform(2))
        
        if rand == 0 {
            enemy = Kulik(startingHp: 60, attackPwr: 12)
            enemyImg.hidden = false
        } else {
            enemy = DevilKulik(startingHp: 90, attackPwr: 15)
            enemy2Img.hidden = false
        }
        
        
    }
    
    @IBAction func attackTapped(sender: AnyObject) {
        
        playSound()
        
        if enemy.attemptAttack(player.attackPwr){
            printLbl.text = "Attacked \(enemy.type) for \(player.attackPwr) HP"
            enemyHpLbl.text = "\(enemy.hp) HP"
            
        } else {
            printLbl.text = "Unsuccessful Attack!"
        }
        
        if player.attemptAttack(enemy.attackPwr) {
            printLbl.text = "\(player.name) was attacked  by \(enemy.type) for \(enemy.attackPwr) HP"
            playerHpLbl.text = "\(player.hp) HP"
        } else {
            printLbl.text = "Unsuccessful Attack!"
            playerHpLbl.text = "\(player.hp) HP"
        }
        
        if player.hp <= 0 {
            playerImg.hidden = true
            playerHpLbl.hidden = true
            printLbl.text = "\(player.name) was killed by \(enemy.type)"
            NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "printLbl", userInfo: nil, repeats: false)
            restartBtn.hidden = false
            attackBtn.hidden = true
            printLbl.text = "\(player.name) do you want to restart game? "
            
        }
  
        if let loot = enemy.dropLoot(){
            player.addItemToInventory(loot)
            chestMsg = "\(player.name) found \(loot)"
            chestBtn.hidden = false
        }
        
        if !enemy.isAlive {
            enemyHpLbl.text = ""
            printLbl.text = " Killed \(enemy.type)"
            enemyImg.hidden = true
            enemy2Img.hidden = true
        }
        
        
    }
    
    func restartGame() {
        player = Player(name: "PeterZig23", hp: 110, attackPwr: 20)
        
        attackBtn.hidden = false
        playerImg.hidden = false
        playerHpLbl.hidden = false
        playerHpLbl.text = "\(player.hp) HP"
        
        printLbl.text = "Press 'Attack' to attack!"
    }
    
    @IBAction func restartTapped(sender: AnyObject) {
        restartBtn.hidden = true
        restartGame()
    }
    
    @IBAction func onChestTapped(sender: AnyObject) {
        chestBtn.hidden = true
        printLbl.text = chestMsg
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "generateRandomEnemy", userInfo: nil, repeats: false)
        //timer for generating new enemy 2 secs
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }

}

