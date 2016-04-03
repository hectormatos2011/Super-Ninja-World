//
//  MagicNumbers.swift
//  SuperNinjaWorld
//
//  Created by Hector Matos on 4/2/16.
//  Copyright © 2016 Hector Matos. All rights reserved.
//

import CoreGraphics

struct Constants {
    struct Scene {
        struct Button {
            static let size: CGFloat = 60.0
            static let margin: CGFloat = 20.0
            static let midMargin: CGFloat = 15.0

            static let aImageFileName = "AButton"
            static let leftImageFileName = "LeftButton"
            static let rightImageFileName = "RightButton"
        }
    }
    struct Player {
        static let maxSpeed: CGFloat = 300.0
        static let velocityIncrement: CGFloat = 10.0
        static let verticalJumpSpeed: CGFloat = 700.0
    }
}