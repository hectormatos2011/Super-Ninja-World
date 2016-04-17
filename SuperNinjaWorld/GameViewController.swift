//
//  GameViewController.swift
//  Super Ninja World
//
//  Created by Hector Matos on 2/27/16.
//  Copyright (c) 2016 Hector Matos. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    var scene: GameScene? {
        return (view as? SKView)?.scene as? GameScene
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view.
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.showsPhysics = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        skView.presentScene(setUpScene())
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func setUpScene() -> GameScene {
        let scene = GameScene(fileNamed: String(GameScene))!
        scene.scaleMode = .ResizeFill
        
        return scene
    }
}