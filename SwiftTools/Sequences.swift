//
//  List.swift
//  SwiftTools
//
//  Created by Jonah Witcig on 11/10/16.
//  Copyright © 2016 JwitApps. All rights reserved.
//

public extension Collection {
   public subscript(safe index: Index) -> Iterator.Element? {
        guard index >= startIndex, index <= endIndex else { return nil }
        return self[index]
    }
}

public extension Array where Element : Hashable {
    public var unique: [Element] {
        return set.array
    }
    
    public var set: Set<Element> {
        return Set(self)
    }
}

public extension Sequence where Iterator.Element == Date {
    public var chronological: [Date] {
        return sorted()
    }
}

public extension Set {
    public var array: [Iterator.Element] {
        return Array(self)
    }
}
