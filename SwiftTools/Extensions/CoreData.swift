//
//  CoreData.swift
//  SwiftTools
//
//  Created by Developer on 3/8/16.
//  Copyright © 2016 JwitApps. All rights reserved.
//

import CoreData

public extension NSManagedObject {
    subscript(key: String) -> AnyObject? {
        get { return value(forKey: key) as AnyObject? }
        set { setValue(newValue, forKey: key) }
    }
}

public extension NSManagedObjectContext {
    convenience init(parentContext: NSManagedObjectContext? = nil) {
        guard let parentManagedObjectContext = parentContext else {
            self.init(concurrencyType: .mainQueueConcurrencyType)
            return
        }
        self.init(concurrencyType: .privateQueueConcurrencyType)
        self.parent = parentManagedObjectContext
    }

    func crossContextEquivalent<T: NSManagedObject>(_ object: T) -> T {
        return self.object(with: object.objectID) as! T
    }

    func crossContextEquivalents<T: NSManagedObject>(_ objects: [T]) -> [T] {
        return objects.map { crossContextEquivalent($0) }
    }

    class var currentThread: NSManagedObjectContext {
        return NSManagedObjectContext.context(forThread: Thread.current)
    }
    
    class var mainThread: NSManagedObjectContext {
        return NSManagedObjectContext.context(forThread: Thread.main)
    }

    class func context(forThread thread: Thread) -> NSManagedObjectContext {
        if let context = NSManagedObjectContext.threadContexts[thread] { return context }

        let newContext = NSManagedObjectContext(parentContext: .mainThread)
        NSManagedObjectContext.threadContexts[thread] = newContext
        return newContext
    }

    fileprivate static var threadContexts = [Thread.main: NSManagedObjectContext(parentContext: nil)]
}

public extension Collection where Iterator.Element: NSManagedObject {
    var objectIDs: [NSManagedObjectID] {
        return map {$0.objectID}
    }
}
