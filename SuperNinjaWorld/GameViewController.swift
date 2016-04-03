//
//  GameViewController.swift
//  Super Ninja World
//
//  Created by Hector Matos on 2/27/16.
//  Copyright (c) 2016 Hector Matos. All rights reserved.
//

import UIKit
import SpriteKit

private extension Selector {
    static let moveLeft = #selector(GameViewController.moveLeft)
    static let moveRight = #selector(GameViewController.moveRight)
    static let jump = #selector(GameViewController.jump)
}

class GameViewController: UIViewController {
    var scene: GameScene? {
        return (view as? SKView)?.scene as? GameScene
    }
    
    lazy var commands: [UIKeyCommand] = {
        return [
            UIKeyCommand(input: UIKeyInputLeftArrow, modifierFlags: UIKeyModifierFlags(), action: .moveLeft),
            UIKeyCommand(input: UIKeyInputRightArrow, modifierFlags: UIKeyModifierFlags(), action: .moveRight),
            UIKeyCommand(input: " ", modifierFlags: UIKeyModifierFlags(), action: .jump)
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view.
        let skView = self.view as! SKView
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

// MARK: UIKeyCommand Enabling/Functions
extension GameViewController {
    override var keyCommands: [UIKeyCommand] { return commands }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    func moveLeft() {
        scene?.moveLeft()
    }
    
    func moveRight() {
        scene?.moveRight()
    }
    
    func jump() {
        scene?.jump()
    }
}
