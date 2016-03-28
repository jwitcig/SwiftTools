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
            return valueForKey(key)
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
            self.init(concurrencyType: .MainQueueConcurrencyType)
            selfObject = self
            return
        }

        self.init(concurrencyType: .PrivateQueueConcurrencyType)
        self.parentContext = parentManagedObjectContext
        selfObject = self
    }

    public func crossContextEquivalent<T: NSManagedObject>(object object: T) -> T {
        return self.objectWithID(object.objectID) as! T
    }

    public func crossContextEquivalents<T: NSManagedObject>(objects objects: [T]) -> [T] {
        return objects.map { self.crossContextEquivalent(object: $0) }
    }

    public class func contextForCurrentThread() -> NSManagedObjectContext {
        return NSManagedObjectContext.contextForThread(NSThread.currentThread())
    }

    public class func contextForThread(thread: NSThread) -> NSManagedObjectContext {
        if let context = NSManagedObjectContext.threadContexts[thread] { return context }

        let mainThreadContext = NSManagedObjectContext.contextForThread(NSThread.mainThread())
        let newContext = NSManagedObjectContext(parentContext: mainThreadContext)
        NSManagedObjectContext.threadContexts[thread] = newContext
        return newContext
    }

    private static var threadContexts = [NSThread.mainThread(): NSManagedObjectContext(parentContext: nil)]

}

public extension CollectionType where Generator.Element: NSManagedObject {
    public var objectIDs: [NSManagedObjectID] {
        return map { $0.objectID }
    }
}
