//
//  Representation.swift
//  SwiftTools
//
//  Created by Jonah Witcig on 11/10/16.
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
        get { return values[key] as Any }
        set { values[key] = newValue }
    }
}
