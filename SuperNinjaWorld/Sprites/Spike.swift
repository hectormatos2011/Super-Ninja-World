//
//  Enemy.swift
//  Super Ninja World
//
//  Created by Hector Matos on 3/17/16.
//  Copyright © 2016 Hector Matos. All rights reserved.
//

import SpriteKit

class Spike: SKSpriteNode {
    var multiplier: CGFloat = -1.0

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpBitMasks()
    }
}

//MARK: GameNode Protocol Functions
extension Spike: GameNode {
    func setUpBitMasks() {
    }
    
    func update(currentTime: CFTimeInterval) {
        position.x += Constants.Enemy.xPositionIncrement * multiplier
    }
}
