//
//  Structs.swift
//  SwiftTools
//
//  Created by Jonah Witcig on 10/25/16.
//  Copyright © 2016 JwitApps. All rights reserved.
//

import GameplayKit

@available(iOS 9.0, *)
public struct RandomPointGenerator {
    private let x: GKRandomDistribution
    private let y: GKRandomDistribution
    
    public init(x: (low: Int, high: Int), y: (low: Int, high: Int), source: GKRandomSource) {
        self.x = GKRandomDistribution(randomSource: source, lowestValue: x.low, highestValue: x.high)
        self.y = GKRandomDistribution(randomSource: source, lowestValue: y.low, highestValue: y.high)
    }
    
    public func newPoint() -> CGPoint {
        return CGPoint(x: x.nextInt(), y: y.nextInt())
    }
}

