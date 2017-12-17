//
//  AssociatedList.swift
//  SwiftTools
//
//  Created by Jonah Witcig on 10/25/16.
//  Copyright © 2016 JwitApps. All rights reserved.
//

public protocol AssociatedList: Sequence, IteratorProtocol {
    associatedtype ListType
    
    var count: Int { get set }
    
    var elements: [ListType] { get set }
    
    init(elements: [ListType])
}

public extension AssociatedList {
    init() {
        self.init()
        self.elements = []
    }
    
    init(elements: [ListType]) {
        self.init()
        self.elements = elements
    }
    
    mutating func next() -> ListType? {
        count += 1
        return elements[safe: count]
    }
}


