//
//  Player.swift
//  Super Ninja World
//
//  Created by Hector Matos on 3/17/16.
//  Copyright © 2016 Hector Matos. All rights reserved.
//

import SpriteKit

protocol DeathDelegate: class {
    func andThatsAllSheWrote()
}

class Player: SKSpriteNode {
    var action: ActionType = .None
    weak var delegate: DeathDelegate?
    lazy var actions: [ActionType : SKAction] = self.loadActions()

    var multiplier: CGFloat {
        if action.contains(.Move) {
            return action.contains(.FaceLeft) ? -1 : 1
        } else {
            return 0
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpBitMasks()
    }
    
    func update(currentTime: CFTimeInterval) {
        guard var velocity = physicsBody?.velocity else {
            return
        }
        
        velocity.dx += Constants.Player.velocityIncrement * multiplier
        
        if velocity.dx < 0 {
            velocity.dx = max(velocity.dx, -Constants.Player.maxSpeed)
        } else {
            velocity.dx = min(velocity.dx, Constants.Player.maxSpeed)
        }
        
        physicsBody?.velocity = velocity
    }
}

// MARK: Key Commands!
extension Player {
    func moveLeft() {
        guard action != .Dying && !action.contains([.Move, .FaceLeft]) else { return }
        
        let newAction: ActionType = [.Move, .FaceLeft]
        removeAllActions()
        runAction(actions[newAction]!)
        
        action.remove([.Stationary, .FaceRight])
        action.insert(newAction)
    }
    
    func moveRight() {
        guard action != .Dying && !action.contains([.Move, .FaceRight]) else { return }
        
        let newAction: ActionType = [.Move, .FaceRight]
        removeAllActions()
        runAction(actions[newAction]!)
        
        action.remove([.Stationary, .FaceLeft])
        action.insert(newAction)
    }
    
    func jump() {
        guard !action.contains(.Dying) && !action.contains(.Jump) else { return }
        
        removeAllActions()

        if action.contains(.FaceLeft) {
            let newAction: ActionType = [.FaceLeft, .Jump]
            runAction(actions[newAction]!)
            action.insert(newAction)
        } else {
            let newAction: ActionType = [.FaceRight, .Jump]
            runAction(actions[newAction]!)
            action.insert(newAction)
        }
        
        physicsBody?.velocity.dy = Constants.Player.verticalJumpSpeed
    }
    
    func stopMoving() {
        guard action != .Dying && !action.contains([.Stationary]) else { return }
        
        let newAction: ActionType
        if action.contains(.FaceLeft) {
            newAction = [.Stationary, .FaceLeft]
        } else {
            newAction = [.Stationary, .FaceRight]
        }
        
        removeAllActions()
        runAction(actions[newAction]!)
        
        action.remove([.Move])
        action.insert(newAction)
    }
}

// MARK: Action Loading Functions
extension Player {
    func loadActions() -> [ActionType : SKAction] {
        let typesWithSKSFileActions: [ActionType] = [
            [.FaceLeft, .Stationary],
            [.FaceRight, .Stationary],
            [.FaceLeft, .Jump],
            [.FaceRight, .Jump],
            [.FaceLeft, .Move],
            [.FaceRight, .Move],
        ]
        
        var actions = [ActionType : SKAction]()
        for type in typesWithSKSFileActions {
            print(String(type))
            if let action = SKAction(named: String(type)) {
                actions[type] = action
            }
        }
        
        return actions
    }
}

//MARK: GameNode Protocol Functions
extension Player: GameNode {
    func setUpBitMasks() {
        categorySetType = .Player
        contactTestSetType = [.Spike, .Plant, .Block, .Pipe, .Ground]
        collisionSetType = [.Ground, .Block, .Scene, .Pipe]
    }
    
    func collidedWith(node: GameNode) {
        guard let sprite = node.node as? SKSpriteNode else { return }
        
        if (node.categorySetType == .Spike || node.categorySetType == .Plant) && action != .Dying {
            action = .Dying
            collisionSetType = .None
            physicsBody?.velocity = CGVector(dx: 0.0, dy: Constants.Player.maxSpeed)
            
            delegate?.andThatsAllSheWrote()
        } else if action.contains(.Jump) {
            if frame.maxY > sprite.position.y {
                action.remove(.Jump)
            }
        }
    }
}
