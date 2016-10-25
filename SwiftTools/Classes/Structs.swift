//
//  Structs.swift
//  SwiftTools
//
//  Created by Jonah Witcig on 10/25/16.
//  Copyright © 2016 JwitApps. All rights reserved.
//

public struct AlternativeRepresentation {
    var values = [String: Any?]()
    
    var dictionary: [String: Any] {
        return values.reduce([:], { (result, pair: (key: String, value: Any?)) in
            var dict = result
            
            if let value = pair.value {
                dict[pair.key] = value
            }
            return dict
        })
    }
    
    init(values: [String: Any?]) {
        self.values = values
    }
    
    subscript(key: String) -> Any? {
        get { return values[key] }
        set { values[key] = newValue }
    }
}
