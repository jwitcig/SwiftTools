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
        self.init(recordType: recordType, predicate: NSPredicate.all)
    }
}

public extension CKRecord {
    public func propertyForName<T>(_ name: String, defaultValue: T) -> T {
        return value(forKey: name) as? T ?? defaultValue
    }

    public func referenceForName(_ name: String) -> CKReference? {
        return self[name] as? CKReference
    }

    public func referencesForName(_ name: String) -> Set<CKReference> {
        return (self[name] as? [CKReference] ?? []).set
    }
}

public extension Collection where Iterator.Element: CKRecord {
    public var recordIDs: [CKRecordID] { return map { $0.recordID } }
}

public extension Collection where Iterator.Element: CKRecordID {
    public var recordNames: [String] {
        return map { $0.recordName }
    }
    public var references: [CKReference] {
        return map { CKReference(recordID: $0, action: .none) }
    }
}

public extension Collection where Iterator.Element: CKReference {
    public var recordIDs: [CKRecordID] { return map { $0.recordID } }
}

public extension Collection where Iterator.Element: CKNotification {
    public var IDs: [CKNotificationID] {
        return filter { $0.notificationID != nil }.map { $0.notificationID! }
    }
}
