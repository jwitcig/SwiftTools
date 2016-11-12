//
//  Standard.swift
//  SwiftTools
//
//  Created by Jonah Witcig on 11/10/16.
//  Copyright © 2016 JwitApps. All rights reserved.
//

public extension String {
    public func isBefore(_ toString: String) -> Bool {
        return compare(toString) == .orderedAscending
    }
    
    public func isAfter(_ toString: String) -> Bool {
        return compare(toString) == .orderedDescending
    }
}

// MARK: Conversions

public extension String {
    public var int: Int? { return Int(self) }
    public var double: Double? { return Double(self) }
    public var bool: Bool? { return Bool(self) }
}

public extension Int {
    public var string: String? { return String(describing: self) }
    public var double: Double? { return Double(self) }
    public var cgFloat: CGFloat? { return CGFloat(self) }
    public var float: Float? { return Float(self) }
}

public extension Double {
    public var string: String? { return String(describing: self) }
    public var int: Int? { return Int(self) }
    public var cgFloat: CGFloat? { return CGFloat(self) }
    public var float: Float? { return Float(self) }
}

public extension CGFloat {
    public var string: String? { return String(describing: self) }
    public var int: Int? { return Int(self) }
    public var double: Double? { return Double(self) }
    public var float: Float? { return Float(self) }
}

public extension Bool {
    public var string: String? { return String(self) }
}
