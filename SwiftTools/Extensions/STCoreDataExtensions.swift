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
        get {
            return value(forKey: key)
        }
        set {
            setValue(newValue, forKey: key)
        }
    }
    
}

public extension NSManagedObjectContext {

    public convenience init(parentContext: NSManagedObjectContext? = nil) {
        var selfObject: NSManagedObjectContext!
        defer {
//            NSNotificationCenter.defaultCenter().addObserver(selfObject, selector: Selector("managedObjectContextWillSave:"), name: NSManagedObjectContextWillSaveNotification, object: selfObject)
//            NSNotificationCenter.defaultCenter().addObserver(selfObject, selector: Selector("managedObjectContextDidSave:"), name: NSManagedObjectContextDidSaveNotification, object: selfObject)
        }

        guard let parentManagedObjectContext = parentContext else {
            self.init(concurrencyType: .mainQueueConcurrencyType)
            selfObject = self
            return
        }

        self.init(concurrencyType: .privateQueueConcurrencyType)
        self.parent = parentManagedObjectContext
        selfObject = self
    }

    public func crossContextEquivalent<T: NSManagedObject>(object: T) -> T {
        return self.object(with: object.objectID) as! T
    }

    public func crossContextEquivalents<T: NSManagedObject>(objects: [T]) -> [T] {
        return objects.map { self.crossContextEquivalent(object: $0) }
    }

    public class func contextForCurrentThread() -> NSManagedObjectContext {
        return NSManagedObjectContext.contextForThread(Thread.current())
    }

    public class func contextForThread(_ thread: Thread) -> NSManagedObjectContext {
        if let context = NSManagedObjectContext.threadContexts[thread] { return context }

        let mainThreadContext = NSManagedObjectContext.contextForThread(Thread.main())
        let newContext = NSManagedObjectContext(parentContext: mainThreadContext)
        NSManagedObjectContext.threadContexts[thread] = newContext
        return newContext
    }

    private static var threadContexts = [Thread.main(): NSManagedObjectContext(parentContext: nil)]

}

public extension Collection where Iterator.Element: NSManagedObject {
    public var objectIDs: [NSManagedObjectID] {
        return map { $0.objectID }
    }
}
