//
//  GameScene.swift
//  Super Ninja World
//
//  Created by Hector Matos on 2/27/16.
//  Copyright (c) 2016 Hector Matos. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let leftButton = SKSpriteNode()
    let rightButton = SKSpriteNode()
    let aButton = SKSpriteNode()
    
    lazy var player: Player    = self.childSprite(Player)
    lazy var spike: Spike      = self.childSprite(Spike)
    lazy var enemyPipe: Pipe   = self.childSprite(Pipe)
    lazy var block: Block      = self.childSprite(Block)
    lazy var ground: Ground    = self.childSprite(Ground)
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        player.delegate = self
        
        setUpPhysics(view)
        setUpButtons(view)
        setUpBitMasks()
    }
    
    override func willMoveFromView(view: SKView) {
        super.willMoveFromView(view)
        
        //This function is called when the scene is dismissed.
        let scene = GameScene(fileNamed: String(GameScene))!
        scene.scaleMode = .ResizeFill
        view.presentScene(scene, transition: SKTransition.crossFadeWithDuration(Constants.Scene.deathSceneTransitionDuration))
    }
    
    override func update(currentTime: CFTimeInterval) {
        player.update(currentTime)
        spike.update(currentTime)
    }
}

// MARK: Set Up Functions
extension GameScene {
    func setUpPhysics(view: SKView) {
        //Set up wall so no one jumps off the edge to their inevitable doom. Also, there is not camera. Yet. Unless you want to implement one. Then be our guest, be our guest, put our service to the test! 🤓
        physicsBody = SKPhysicsBody(edgeLoopFromRect: view.bounds)
        physicsWorld.contactDelegate = self
    }

    func setUpButtons(view: SKView) {
        let buttonSize = CGSize(width: Constants.Scene.Button.size, height: Constants.Scene.Button.size)
        leftButton.size = buttonSize
        rightButton.size = buttonSize
        aButton.size = buttonSize

        leftButton.zPosition = Constants.Scene.Button.zPosition
        rightButton.zPosition = Constants.Scene.Button.zPosition
        aButton.zPosition = Constants.Scene.Button.zPosition
        
        leftButton.texture = SKTexture(imageNamed: Constants.Scene.Button.leftImageFileName)
        rightButton.texture = SKTexture(imageNamed: Constants.Scene.Button.rightImageFileName)
        aButton.texture = SKTexture(imageNamed: Constants.Scene.Button.aImageFileName)

        leftButton.position = CGPoint(x: (buttonSize.width / 2.0) + Constants.Scene.Button.margin, y: (buttonSize.height / 2.0) + Constants.Scene.Button.margin)
        rightButton.position = CGPoint(x: leftButton.position.x + buttonSize.width + Constants.Scene.Button.midMargin, y: leftButton.position.y)
        aButton.position = CGPoint(x: view.bounds.width - leftButton.position.x, y: leftButton.position.y)
        
        addChild(leftButton)
        addChild(rightButton)
        addChild(aButton)
    }
}

// MARK: GameNode Protocol Functions
extension GameScene: GameNode {
    func setUpBitMasks() {
        categorySetType = .Scene
    }
}

// MARK: DeathDelegate Protocol Functions
extension GameScene: DeathDelegate {
    func andThatsAllSheWrote() {
        let transition = SKTransition.crossFadeWithDuration(Constants.Scene.deathSceneTransitionDuration)
        let scene = DeathScene(fileNamed: String(DeathScene))!
        scene.scaleMode = .ResizeFill
        view?.presentScene(scene, transition: transition)
    }
}

// MARK: SKPhysicsContactDelegate Functions
extension GameScene: SKPhysicsContactDelegate {
    func didBeginContact(contact: SKPhysicsContact) {
        //the contact bodies passed into this function aren't always ordered in the same way. Sometimes you may get bodyA as the Player and bodyB as the Enemy and vice versa. Let's sort them so we can have consistency. Trust me, consistency is a good thing.
        let (firstBody, secondBody) = contact.bodyA.categoryBitMask <= contact.bodyB.categoryBitMask ? (contact.bodyA, contact.bodyB) : (contact.bodyB, contact.bodyA)

        if let firstNode = firstBody.node as? GameNode, secondNode = secondBody.node as? GameNode {
            firstNode.collidedWith(secondNode)
        }
    }
}

// MARK: Touch Functions
extension GameScene {
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        handleTouches(touches)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesMoved(touches, withEvent: event)
        handleTouches(touches)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        handleTouches(touches, ended: true)
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        super.touchesCancelled(touches, withEvent: event)
        handleTouches(touches, ended: true)
    }

    func handleTouches(touches: Set<UITouch>?, ended: Bool = false) {
        guard let view = view, touches = touches else { return }

        for touch in touches {
            let touchLocation = touch.locationInView(view)
            let moveCenter = CGPoint(x: leftButton.position.x + (leftButton.size.width / 2.0) + (Constants.Scene.Button.midMargin / 2.0), y: 0.0)
            let sceneCenter = CGPoint(x: view.bounds.width / 2.0, y: view.bounds.height / 2.0)
            
            if touchLocation.x < moveCenter.x {
                ended ? player.stopMoving() : player.moveLeft()
            } else if touchLocation.x > moveCenter.x && touchLocation.x < sceneCenter.x {
                ended ? player.stopMoving() : player.moveRight()
            }
            if touchLocation.x >= sceneCenter.x {
                player.jump()
            }
        }
    }
}

// MARK: Sprite Loading Functions
extension GameScene {
    func childSprite<T>(type: T.Type) -> T! {
        guard let sprite = childNodeWithName(String(type)) else {
            fatalError("The corresponding node for this type in your scene is not named properly. Make sure the name field in the sks file matches \"\(String(type))\"")
        }
        return recursiveChild(sprite, type: T.self)
    }
    
    func recursiveChild<T>(node: SKNode, type: T.Type) -> T! {
        if let node = node as? T {
            return node
        }
        
        for child in node.children {
            return recursiveChild(child, type: type)
        }
        return nil
    }
}