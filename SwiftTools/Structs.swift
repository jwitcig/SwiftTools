//
//  Structs.swift
//  SwiftTools
//
//  Created by Jonah Witcig on 10/25/16.
//  Copyright © 2016 JwitApps. All rights reserved.
//

public struct AlternativeRepresentation {
    public var values = [String: Any?]()
    
    public var dictionary: [String: Any] {
        return values.reduce([:], { (result, pair: (key: String, value: Any?)) in
            var dict = result
            
            if let value = pair.value {
                dict[pair.key] = value
            }
            return dict
        })
    }
    
    public init(values: [String: Any?]) {
        self.values = values
    }
    
    public subscript(key: String) -> Any? {
        get { return values[key] }
        set { values[key] = newValue }
    }
}

public protocol Inset {
    var left: Int { get }
    var right: Int { get }
    var top: Int { get }
    var bottom: Int { get }
}

public struct Padding: Inset {
    public let left: Int
    public let right: Int
    public let top: Int
    public let bottom: Int
    
    public init(left: Int=0, right: Int=0, top: Int=0, bottom: Int=0) {
        self.left = left
        self.right = right
        self.top = top
        self.bottom = bottom
    }
}

public protocol LifeCycleable: class {
    var startTime: TimeInterval! { get set }
    var endTime: TimeInterval! { get set }
    
    var started: (()->Void)? { get }
    var finished: (()->Void)? { get }
    
    func start()
    func finish()
}

public extension LifeCycleable {
    public var elapsedTime: TimeInterval {
        return endTime - startTime
    }
    
    public func start() {
        markStartTime()
    }
    
    public func finish() {
        markFinishTime()
    }
    
    public func markStartTime() {
        startTime = Date().timeIntervalSince1970
    }
    
    public func markFinishTime() {
        endTime = Date().timeIntervalSince1970
    }
}

open class LifeCycle: LifeCycleable {
    public var startTime: TimeInterval!
    public var endTime: TimeInterval!
    
    public let started: (() -> Void)?
    public let finished: (() -> Void)?
    
    public init(started: (() -> Void)?, finished: (() -> Void)?) {
        self.started = started
        self.finished = finished
    }
    
    public func start() {
        markStartTime()
        started?()
    }
    
    open func finish() {
        markFinishTime()
        finished?()
    }
}

public protocol DictionaryStoring {
    associatedtype Key: Hashable
    associatedtype Value
    
    var dictionary: Dictionary<Key, Value> { get set }
}

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

