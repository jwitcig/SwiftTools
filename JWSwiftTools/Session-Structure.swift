//
//  Session-Structure.swift
//  SwiftTools
//
//  Created by Jonah Witcig on 11/10/16.
//  Copyright © 2016 JwitApps. All rights reserved.
//

public protocol TypeConstraint { }

public protocol InstanceDataType: SessionDataType { }
public protocol InitialDataType: SessionDataType { }

public protocol SessionTyped {
    associatedtype Session: SessionType
}

public protocol SessionDataType {
    associatedtype Constraint: TypeConstraint
}

public protocol SessionSpecific {
    associatedtype SessionConstraint: SessionType
}
