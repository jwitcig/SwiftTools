//
//  LifeCycle.swift
//  SwiftTools
//
//  Created by Jonah Witcig on 11/10/16.
//  Copyright © 2016 JwitApps. All rights reserved.
//

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
    
    open func start() {
        markStartTime()
        started?()
    }
    
    open func finish() {
        markFinishTime()
        finished?()
    }
}
