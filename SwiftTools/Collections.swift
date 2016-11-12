//
//  Collections.swift
//  SwiftTools
//
//  Created by Jonah Witcig on 11/10/16.
//  Copyright © 2016 JwitApps. All rights reserved.
//

public extension Dictionary {
    public func merged(_ rhs: [Key: Value]) -> [Key: Value] {
        var new = self
        for (key, value) in rhs {
            new.updateValue(value, forKey: key)
        }
        return new
    }
}

public protocol DictionaryRepresentable {
    associatedtype Key: Hashable
    associatedtype Value
    
    var dictionary: [Key: Value] { get }
}

public protocol StringDictionaryRepresentable {
    var dictionary: [String: String] { get }
}

public protocol DictionaryStoring {
    associatedtype Key: Hashable
    associatedtype Value
    
    var dictionary: Dictionary<Key, Value> { get set }
}
