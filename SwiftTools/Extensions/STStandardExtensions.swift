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


public extension Array {
    public subscript (safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }

//    public subscript (safe range: Range<Int>) -> [Element]? {
//        var elements = [Element]()
//        for index in range {
//            if let element = self[safe: index] {
//                elements.append(element)
//            } else {
//                return nil
//            }
//
//        }
//        return elements
//    }
    
}

public extension Array where Element : Hashable {
    public var unique: [Element] {
        return self.set.array
    }
    
    public var set: Set<Element> {
        return Set(self)
    }
}

public extension Date {

    public func isBefore(date: Date) -> Bool {
        return self.compare(date) == .orderedAscending
    }

    public func isSameDay(date: Date) -> Bool {
        return self.compare(date) == .orderedSame
    }

    public static func daysBetween(startDate: Date, endDate: Date) -> Int {
        let calendar = Calendar(calendarIdentifier: Calendar.Identifier.gregorian)!
        let dateComponents = calendar.components(.day, from: startDate, to: endDate, options: Calendar.Options())
        return dateComponents.day!
    }

    public func daysBetween(endDate: Date) -> Int {
        return Date.daysBetween(startDate: self, endDate: endDate)
    }

    public static func daysBeforeToday(originalDate: Date) -> Int {
        return originalDate.daysBeforeToday()
    }

    public func daysBeforeToday() -> Int {
        return Date.daysBetween(startDate: self, endDate: Date())
    }

    static func sorted(dates: [Date]) -> [Date] {
        return dates.sorted { $0.0.isBefore(date: $0.1) }
    }

    public func isBetween(firstDate: Date, secondDate: Date, inclusive: Bool) -> Bool {
        if self.isSameDay(date: firstDate) || self.isSameDay(date: secondDate) {
            if inclusive { return true }
            else { return false }
        }
        return firstDate.isBefore(date: self) && self.isBefore(date: secondDate)
    }

}

public extension Predicate {

    public class var allRows: Predicate {
        return Predicate(value: true)
    }

    public convenience init(key: String, comparator: PredicateComparator, value comparisonValue: AnyObject?) {
        guard let value = comparisonValue else {
            self.init(format: "\(key) \(comparator.rawValue) nil")
            return
        }

        self.init(format: "\(key) \(comparator.rawValue) %@", argumentArray: [value])
    }

}

public extension SortDescriptor {

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
        return self.value(forKey: key)
    }
}

public extension Set {
    public var array: [Iterator.Element] { return Array(self) }
}

public extension String {

//    public var range: Range<String.Index> {
//        return (self.characters.indices)
//    }

//    public func isBefore(string toString: String) -> Bool {
//        return self.compare(toString, options: NSString.CompareOptions.caseInsensitiveSearch, range: self.range, locale: nil) == .orderedAscending
//    }

}
