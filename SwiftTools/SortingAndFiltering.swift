//
//  SortingAndFiltering.swift
//  SwiftTools
//
//  Created by Jonah Witcig on 11/10/16.
//  Copyright © 2016 JwitApps. All rights reserved.
//

public extension Date {
    public func isBefore(_ date: Date) -> Bool {
        return compare(date) == .orderedAscending
    }
    
    public func isAfter(_ date: Date) -> Bool {
        return compare(date) == .orderedAscending
    }
    
    public func isSameDay(_ date: Date) -> Bool {
        return compare(date) == .orderedSame
    }
    
    public static func daysBetween(_ start: Date, end: Date) -> Int {
        return Calendar(identifier: Calendar.Identifier.gregorian)
            .dateComponents([Calendar.Component.day].set, from: start, to: end)
            .day!
    }
    
    public func daysBetween(_ endDate: Date) -> Int {
        return Date.daysBetween(self, end: endDate)
    }
    
    public static func daysBeforeToday(_ originalDate: Date) -> Int {
        return originalDate.daysBeforeToday
    }
    
    public var daysBeforeToday: Int {
        return Date.daysBetween(self, end: Date())
    }
    
    public func isBetween(_ firstDate: Date, secondDate: Date, inclusive: Bool) -> Bool {
        return isSameDay(firstDate) || isSameDay(secondDate)
            ? inclusive
            : firstDate.isBefore(self) && secondDate.isAfter(self)
    }
}

public extension NSPredicate {
    public enum Comparator: String {
        case equals = "=="
        case contains = "CONTAINS"
        case containedIn = "IN"
    }
    
    public class var all: NSPredicate {
        return NSPredicate(value: true)
    }
    
    public convenience init(key: String, comparator: Comparator, value comparisonValue: AnyObject?) {
        guard let value = comparisonValue else {
            self.init(format: "\(key) \(comparator.rawValue) nil")
            return
        }
        self.init(format: "\(key) \(comparator.rawValue) %@", argumentArray: [value])
    }
}

public extension NSSortDescriptor {
    public enum Sort {
        case chronological, reverseChronological
    }
    
    public convenience init(key: String, order: Sort) {
        switch order {
        case .chronological:
            self.init(key: key, ascending: true)
        case .reverseChronological:
            self.init(key: key, ascending: false)
        }
    }
}
