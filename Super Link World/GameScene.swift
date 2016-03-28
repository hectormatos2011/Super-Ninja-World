//
//  GameScene.swift
//  Super Link World
//
//  Created by Hector Matos on 2/27/16.
//  Copyright (c) 2016 Hector Matos. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    lazy var player: Player    = self.childSprite(Player)!
    lazy var enemy: Enemy      = self.childSprite(Enemy)!
    lazy var enemyPipe: Pipe   = self.childSprite(Pipe)!
    lazy var blocks: Block     = self.childSprite(Block)!
    lazy var ground: Ground    = self.childSprite(Ground)!
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        setUpPhysics(view)
    }
    
    override func update(currentTime: CFTimeInterval) {
        player.updatePlayer(currentTime)
        enemy.updateEnemy(currentTime)
    }
}

// MARK: Set Up Functions
extension GameScene {
    func setUpPhysics(view: SKView) {
        //Set up wall so no one jumps off the edge to their inevitable doom. Also, there is not camera. Yet. Unless you want to implement one. Then be our guest, be our guest, put our service to the test! 🤓
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: view.bounds)
        physicsWorld.contactDelegate = self

        setUpBitMasks()
    }
    
    func setUpBitMasks() {
        self.type = .Scene
        
        self.player.type = .Player
        self.player.contactTestBitMask = [.Enemy, .Block, .Pipe, .Ground]
        self.player.collisionBitMask = [.Ground, .Block, .Scene, .Pipe]
        
        self.enemy.type = .Enemy
        self.enemy.contactTestBitMask = [.Pipe, .Scene]
        self.enemy.collisionBitMask = .Ground
        
        self.enemyPipe.type = .Pipe
        
        self.ground.type = .Ground
    }
}

// MARK: SKPhysicsContactDelegate Functions
extension GameScene: SKPhysicsContactDelegate {
    func didBeginContact(contact: SKPhysicsContact) {
        //the contact bodies passed into this function aren't always ordered in the same way. Sometimes you may get bodyA as the Player and bodyB as the Enemy and vice versa. Let's sort them so we can have consistency. Trust me, consistency is a good thing.
        var firstBody = contact.bodyA
        var secondBody = contact.bodyB
        if firstBody.categoryBitMask > contact.bodyB.categoryBitMask {
            swap(&firstBody, &secondBody)
        }

        if let firstNode = firstBody.node as? GameNode, secondNode = secondBody.node as? GameNode {
            firstNode.collidedWith(secondNode)
        }
    }
}

extension GameScene: GameNode {
    func collidedWith(node: GameNode) {
        print("\(type) collided with \(node.type).")
    }
}

// MARK: Key Commands!
extension GameScene {
    func moveLeft() {
        player.moveLeft()
    }
    
    func moveRight() {
        player.moveRight()
    }
    
    func jump() {
        player.jump()
    }
}

// MARK: Sprite Loading Functions
extension GameScene {
    func childSprite<T>(type: T.Type) -> T? {
        guard let sprite = childNodeWithName(String(type)) else {
            return nil
        }
        return recursiveChild(sprite, type: T.self)
    }
    
    func recursiveChild<T>(node: SKNode, type: T.Type) -> T? {
        if let node = node as? T {
            return node
        }
        
        for child in node.children {
            return recursiveChild(child, type: type)
        }
        return nil
    }
}