//
//  STStandard.swift
//  SwiftTools
//
//  Created by Developer on 3/8/16.
//  Copyright © 2016 JwitApps. All rights reserved.
//

#if os(iOS)
    import UIKit
#elseif os(OSX)
    import Cocoa
#endif

import MapKit

public extension Array {
    public subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }

    public subscript(safe range: Range<Int>) -> [Element]? {
        let elements = (range.lowerBound...range.upperBound).map { self[safe: $0] }
        return elements.filter { $0 == nil }
            .count > 0 ? nil : elements.map { $0! }
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

public extension Date {
    public func isBefore(date: Date) -> Bool {
        return compare(date) == .orderedAscending
    }
    
    public func isAfter(date: Date) -> Bool {
        return compare(date) == .orderedAscending
    }

    public func isSameDay(date: Date) -> Bool {
        return compare(date) == .orderedSame
    }

    public static func daysBetween(start: Date, end: Date) -> Int {
        return Calendar(identifier: Calendar.Identifier.gregorian)
                .dateComponents([Calendar.Component.day].set, from: start, to: end)
                .day!
    }

    public func daysBetween(endDate: Date) -> Int {
        return Date.daysBetween(start: self, end: endDate)
    }

    public static func daysBeforeToday(originalDate: Date) -> Int {
        return originalDate.daysBeforeToday
    }

    public var daysBeforeToday: Int {
        return Date.daysBetween(start: self, end: Date())
    }

    static func sorted(dates: [Date]) -> [Date] {
        return dates.sorted { $0.0.isBefore(date: $0.1) }
    }

    public func isBetween(firstDate: Date, secondDate: Date, inclusive: Bool) -> Bool {
        return isSameDay(date: firstDate) || isSameDay(date: secondDate)
            ? inclusive
            : firstDate.isBefore(date: self) && secondDate.isAfter(date: self)
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

public extension UserDefaults {
    public subscript(key: String) -> AnyObject? {
        return value(forKey: key) as AnyObject?
    }
}

public extension Set {
    public var array: [Iterator.Element] {
        return Array(self)
    }
}

public func ==<T: Hashable>(lhs: T, rhs: T) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

public extension NSLayoutConstraint {
    func hasExceeded(_ verticalLimit: CGFloat) -> Bool {
        return constant < verticalLimit
    }
}

public extension UITextView {
    public func recalculateVerticalAlignment() {
        let calculatedY = (bounds.size.height - contentSize.height * zoomScale) / 2.0
        contentInset = UIEdgeInsets(top: calculatedY < 0 ? 0 : calculatedY, left: 0, bottom: 0, right: 0)
    }
}

public extension MKMapView {
    func clear() {
        removeAnnotations(annotations)
    }
}

public extension String {
    public func isBefore(_ toString: String) -> Bool {
        return compare(toString) == .orderedAscending
    }
    
    public func isAfter(_ toString: String) -> Bool {
        return compare(toString) == .orderedDescending
    }
}
