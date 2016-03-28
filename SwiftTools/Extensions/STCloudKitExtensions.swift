//
//  STCloudKit.swift
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

import CloudKit

public extension CKQuery {

    public convenience init(recordType: String) {
        self.init(recordType: recordType, predicate: NSPredicate.allRows)
    }

}

public extension CKRecord {

    public func propertyForName<T>(name: String, defaultValue: T) -> T {
        guard let storedValue = self.valueForKey(name) as? T else { return defaultValue }
        return storedValue
    }

    public func referenceForName(name: String) -> CKReference? {
        return self[name] as? CKReference
    }

    public func referencesForName(name: String) -> Set<CKReference> {
        let references = self[name] as? [CKReference]
        return references != nil ? Set(references!) : Set()
    }

}

public extension CollectionType where Generator.Element : CKRecord {

    public var recordIDs: [CKRecordID] { return map { $0.recordID } }
}

public extension CollectionType where Generator.Element : CKRecordID {

    public var recordNames: [String] { return map { $0.recordName } }
    public var references: [CKReference] { return map { CKReference(recordID: $0, action: .None) } }
}

public extension CollectionType where Generator.Element : CKReference {

    public var recordIDs: [CKRecordID] { return map { $0.recordID } }
}

public extension CollectionType where Generator.Element : CKNotification {
    
    public var notificationIDs: [CKNotificationID] {
        var IDs = [CKNotificationID]()
        forEach {
            if let notificationID = $0.notificationID {
                IDs.append(notificationID)
            }
        }
        return IDs
    }
}
