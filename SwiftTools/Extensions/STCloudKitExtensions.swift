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
        self.init(recordType: recordType, predicate: Predicate.allRows)
    }

}

public extension CKRecord {

    public func propertyForName<T>(_ name: String, defaultValue: T) -> T {
        guard let storedValue = self.value(forKey: name) as? T else { return defaultValue }
        return storedValue
    }

    public func referenceForName(_ name: String) -> CKReference? {
        return self[name] as? CKReference
    }

    public func referencesForName(_ name: String) -> Set<CKReference> {
        let references = self[name] as? [CKReference]
        return references != nil ? Set(references!) : Set()
    }

}

public extension Collection where Iterator.Element : CKRecord {

    public var recordIDs: [CKRecordID] { return map { $0.recordID } }
}

public extension Collection where Iterator.Element : CKRecordID {

    public var recordNames: [String] { return map { $0.recordName } }
    public var references: [CKReference] { return map { CKReference(recordID: $0, action: .none) } }
}

public extension Collection where Iterator.Element : CKReference {

    public var recordIDs: [CKRecordID] { return map { $0.recordID } }
}

public extension Collection where Iterator.Element : CKNotification {
    
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
