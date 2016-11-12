//
//  Session.swift
//  SwiftTools
//
//  Created by Jonah Witcig on 11/10/16.
//  Copyright © 2016 JwitApps. All rights reserved.
//

public protocol SessionType {
    associatedtype Key: Hashable
    associatedtype Value
    
    associatedtype InitialData: InitialDataType
    associatedtype InstanceData: InstanceDataType
    
    var ended: Bool { get }
    
    var initial: InitialData { get }
    var instance: InstanceData { get }
    
    init?(dictionary: [Key : Value])
}

open class SessionCycle<S: SessionType>: LifeCycle {
    public init(started: (() -> Void)?,
                finished: @escaping (S) -> Void,
                generateSession: @escaping () -> S) {
        
        super.init(started: started, finished: {
            finished(generateSession())
        })
    }
}
