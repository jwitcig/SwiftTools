//
//  STCoreData.swift
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

import CoreData

public extension NSManagedObject {
    public subscript(key: String) -> AnyObject? {
        get { return value(forKey: key) as AnyObject? }
        set { setValue(newValue, forKey: key) }
    }
}

public extension NSManagedObjectContext {
    public convenience init(parentContext: NSManagedObjectContext? = nil) {
        guard let parentManagedObjectContext = parentContext else {
            self.init(concurrencyType: .mainQueueConcurrencyType)
            return
        }
        self.init(concurrencyType: .privateQueueConcurrencyType)
        self.parent = parentManagedObjectContext
    }

    public func crossContextEquivalent<T: NSManagedObject>(object: T) -> T {
        return self.object(with: object.objectID) as! T
    }

    public func crossContextEquivalents<T: NSManagedObject>(objects: [T]) -> [T] {
        return objects.map { crossContextEquivalent(object: $0) }
    }

    public class var currentThread: NSManagedObjectContext {
        return NSManagedObjectContext.context(forThread: Thread.current)
    }
    
    public class var mainThread: NSManagedObjectContext {
        return NSManagedObjectContext.context(forThread: Thread.main)
    }

    public class func context(forThread thread: Thread) -> NSManagedObjectContext {
        if let context = NSManagedObjectContext.threadContexts[thread] { return context }

        let newContext = NSManagedObjectContext(parentContext: .mainThread)
        NSManagedObjectContext.threadContexts[thread] = newContext
        return newContext
    }

    private static var threadContexts = [Thread.main: NSManagedObjectContext(parentContext: nil)]
}

public extension Collection where Iterator.Element: NSManagedObject {
    public var objectIDs: [NSManagedObjectID] {
        return map {$0.objectID}
    }
}
