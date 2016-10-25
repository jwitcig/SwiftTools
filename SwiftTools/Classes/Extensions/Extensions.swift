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
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }

    subscript(safe range: Range<Int>) -> [Element]? {
        let elements = (range.lowerBound...range.upperBound).map { self[safe: $0] }
        return elements.filter { $0 == nil }
            .count > 0 ? nil : elements.map { $0! }
    }
}

public extension Array where Element : Hashable {
    var unique: [Element] {
        return set.array
    }
    
    var set: Set<Element> {
        return Set(self)
    }
}

public extension Date {
    func isBefore(date: Date) -> Bool {
        return compare(date) == .orderedAscending
    }
    
    func isAfter(date: Date) -> Bool {
        return compare(date) == .orderedAscending
    }

    func isSameDay(date: Date) -> Bool {
        return compare(date) == .orderedSame
    }

    static func daysBetween(start: Date, end: Date) -> Int {
        return Calendar(identifier: Calendar.Identifier.gregorian)
                .dateComponents([Calendar.Component.day].set, from: start, to: end)
                .day!
    }

    func daysBetween(endDate: Date) -> Int {
        return Date.daysBetween(start: self, end: endDate)
    }

    static func daysBeforeToday(originalDate: Date) -> Int {
        return originalDate.daysBeforeToday
    }

    var daysBeforeToday: Int {
        return Date.daysBetween(start: self, end: Date())
    }

    func sorted(dates: [Date]) -> [Date] {
        return dates.sorted { $0.0.isBefore(date: $0.1) }
    }

    func isBetween(firstDate: Date, secondDate: Date, inclusive: Bool) -> Bool {
        return isSameDay(date: firstDate) || isSameDay(date: secondDate)
            ? inclusive
            : firstDate.isBefore(date: self) && secondDate.isAfter(date: self)
    }
}

public extension NSPredicate {
    enum Comparator: String {
        case equals = "=="
        case contains = "CONTAINS"
        case containedIn = "IN"
    }
    
    class var all: NSPredicate {
        return NSPredicate(value: true)
    }

    convenience init(key: String, comparator: Comparator, value comparisonValue: AnyObject?) {
        guard let value = comparisonValue else {
            self.init(format: "\(key) \(comparator.rawValue) nil")
            return
        }
        self.init(format: "\(key) \(comparator.rawValue) %@", argumentArray: [value])
    }
}

public extension NSSortDescriptor {
    enum Sort {
        case chronological, reverseChronological
    }
    
    convenience init(key: String, order: Sort) {
        switch order {
        case .chronological:
            self.init(key: key, ascending: true)
        case .reverseChronological:
            self.init(key: key, ascending: false)
        }
    }
}

public extension UserDefaults {
    subscript(key: String) -> AnyObject? {
        return value(forKey: key) as AnyObject?
    }
}

public extension Set {
    var array: [Iterator.Element] {
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
    func recalculateVerticalAlignment() {
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
    func isBefore(_ toString: String) -> Bool {
        return compare(toString) == .orderedAscending
    }
    
    func isAfter(_ toString: String) -> Bool {
        return compare(toString) == .orderedDescending
    }
}
