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
import Messages

infix operator |
public func | (shouldCall: Bool, function: (()->Void)?) {
    if shouldCall {
        function?()
    }
}

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

public extension Sequence where Iterator.Element == Date {
    var chronological: [Date] {
        return sorted()
    }
}

public extension Dictionary {
    public func merged(_ rhs: [Key: Value]) -> [Key: Value] {
        var new = self
        for (key, value) in rhs {
            new.updateValue(value, forKey: key)
        }
        return new
    }
}

public extension Date {
    func isBefore(_ date: Date) -> Bool {
        return compare(date) == .orderedAscending
    }
    
    func isAfter(_ date: Date) -> Bool {
        return compare(date) == .orderedAscending
    }

    func isSameDay(_ date: Date) -> Bool {
        return compare(date) == .orderedSame
    }

    static func daysBetween(_ start: Date, end: Date) -> Int {
        return Calendar(identifier: Calendar.Identifier.gregorian)
                .dateComponents([Calendar.Component.day].set, from: start, to: end)
                .day!
    }

    func daysBetween(_ endDate: Date) -> Int {
        return Date.daysBetween(self, end: endDate)
    }

    static func daysBeforeToday(_ originalDate: Date) -> Int {
        return originalDate.daysBeforeToday
    }

    var daysBeforeToday: Int {
        return Date.daysBetween(self, end: Date())
    }

    func isBetween(_ firstDate: Date, secondDate: Date, inclusive: Bool) -> Bool {
        return isSameDay(firstDate) || isSameDay(secondDate)
            ? inclusive
            : firstDate.isBefore(self) && secondDate.isAfter(self)
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

public extension UIScreen {
    static var size: CGSize {
        return UIScreen.main.bounds.size
    }
}

@available(iOS 10.0, *)
public extension MSMessage {
    static func isFromCurrentDevice(message: MSMessage, conversation: MSConversation) -> Bool {
        return message.senderParticipantIdentifier == conversation.localParticipantIdentifier
    }
}

public extension String {
    var int: Int? { return Int(self) }
    var double: Double? { return Double(self) }
    var bool: Bool? { return Bool(self) }
}

public extension Int {
    var string: String? { return String(describing: self) }
    var double: Double? { return Double(self) }
    var cgFloat: CGFloat? { return CGFloat(self) }
    var float: Float? { return Float(self) }
}

public extension Double {
    var string: String? { return String(describing: self) }
    var int: Int? { return Int(self) }
    var cgFloat: CGFloat? { return CGFloat(self) }
    var float: Float? { return Float(self) }
}

public extension CGFloat {
    var string: String? { return String(describing: self) }
    var int: Int? { return Int(self) }
    var double: Double? { return Double(self) }
    var float: Float? { return Float(self) }
}

public extension Bool {
    var string: String? { return String(self) }
}
