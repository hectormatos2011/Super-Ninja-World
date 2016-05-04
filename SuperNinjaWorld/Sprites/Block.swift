//
//  Block.swift
//  Super Ninja World
//
//  Created by Hector Matos on 3/28/16.
//  Copyright © 2016 Hector Matos. All rights reserved.
//

import SpriteKit

class Block: SKSpriteNode {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpBitMasks()
    }
}

//MARK: GameNode Protocol Functions
extension Block: GameNode {
    func setUpBitMasks() {
        //REPLACE WITH BITMASK SETUP CODE
    }
}
