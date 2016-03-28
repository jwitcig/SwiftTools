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

    public subscript (safe range: Range<Int>) -> [Element]? {
        var elements = [Element]()
        for index in range {
            if let element = self[safe: index] {
                elements.append(element)
            } else {
                return nil
            }

        }
        return elements
    }
    
}

public extension Array where Element : Hashable {
    public var unique: [Element] {
        return self.set.array
    }
    
    public var set: Set<Element> {
        return Set(self)
    }
}

public extension NSDate {

    public func isBefore(date date: NSDate) -> Bool {
        return self.compare(date) == .OrderedAscending
    }

    public func isSameDay(date date: NSDate) -> Bool {
        return self.compare(date) == .OrderedSame
    }

    public class func daysBetween(startDate startDate: NSDate, endDate: NSDate) -> Int {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let dateComponents = calendar.components(.Day, fromDate: startDate, toDate: endDate, options: NSCalendarOptions())
        return dateComponents.day
    }

    public func daysBetween(endDate endDate: NSDate) -> Int {
        return NSDate.daysBetween(startDate: self, endDate: endDate)
    }

    public class func daysBeforeToday(originalDate originalDate: NSDate) -> Int {
        return originalDate.daysBeforeToday()
    }

    public func daysBeforeToday() -> Int {
        return NSDate.daysBetween(startDate: self, endDate: NSDate())
    }

    class func sorted(dates dates: [NSDate]) -> [NSDate] {
        return dates.sort { $0.0.isBefore(date: $0.1) }
    }

    public func isBetween(firstDate firstDate: NSDate, secondDate: NSDate, inclusive: Bool) -> Bool {
        if self.isSameDay(date: firstDate) || self.isSameDay(date: secondDate) {
            if inclusive { return true }
            else { return false }
        }
        return firstDate.isBefore(date: self) && self.isBefore(date: secondDate)
    }

}

public extension NSPredicate {

    public class var allRows: NSPredicate {
        return NSPredicate(value: true)
    }

    public convenience init(key: String, comparator: PredicateComparator, value comparisonValue: AnyObject?) {
        guard let value = comparisonValue else {
            self.init(format: "\(key) \(comparator.rawValue) nil")
            return
        }

        self.init(format: "\(key) \(comparator.rawValue) %@", argumentArray: [value])
    }

}

public extension NSSortDescriptor {

    public convenience init(key: String, order: Sort) {
        switch order {
        case .Chronological:
            self.init(key: key, ascending: true)
        case .ReverseChronological:
            self.init(key: key, ascending: false)
        }
    }

}

public extension NSUserDefaults {
    public subscript(key: String) -> AnyObject? {
        return self.valueForKey(key)
    }
}

public extension Set {
    public var array: [Generator.Element] { return Array(self) }
}

public extension String {

    public var range: Range<String.Index> {
        return Range<String.Index>(start: self.startIndex, end: self.endIndex)
    }

    public func isBefore(string toString: String) -> Bool {
        return self.compare(toString, options: NSStringCompareOptions.CaseInsensitiveSearch, range: self.range, locale: nil) == .OrderedAscending
    }

}
