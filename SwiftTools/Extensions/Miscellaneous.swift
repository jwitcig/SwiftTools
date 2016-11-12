//
//  MiscellaneousExtensions.swift
//  SwiftTools
//
//  Created by Developer on 3/8/16.
//  Copyright © 2016 JwitApps. All rights reserved.
//

public extension UserDefaults {
    public subscript(key: String) -> AnyObject? {
        return value(forKey: key) as AnyObject?
    }
}

public func ==<T: Hashable>(lhs: T, rhs: T) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
