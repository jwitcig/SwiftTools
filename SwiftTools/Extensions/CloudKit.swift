//
//  CloudKit.swift
//  SwiftTools
//
//  Created by Developer on 3/8/16.
//  Copyright © 2016 JwitApps. All rights reserved.
//

import CloudKit

public extension CKQuery {
    convenience init(recordType: String) {
        self.init(recordType: recordType, predicate: NSPredicate.all)
    }
}

public extension CKRecord {
    func propertyForName<T>(_ name: String, defaultValue: T) -> T {
        return value(forKey: name) as? T ?? defaultValue
    }

    func referenceForName(_ name: String) -> CKReference? {
        return self[name] as? CKReference
    }

    func referencesForName(_ name: String) -> Set<CKReference> {
        return (self[name] as? [CKReference] ?? []).set
    }
}

public extension Collection where Iterator.Element: CKRecord {
    var recordIDs: [CKRecordID] { return map { $0.recordID } }
}

public extension Collection where Iterator.Element: CKRecordID {
    var recordNames: [String] {
        return map { $0.recordName }
    }
    var references: [CKReference] {
        return map { CKReference(recordID: $0, action: .none) }
    }
}

public extension Collection where Iterator.Element: CKReference {
    var recordIDs: [CKRecordID] { return map { $0.recordID } }
}

public extension Collection where Iterator.Element: CKNotification {
    var IDs: [CKNotificationID] {
        return filter { $0.notificationID != nil }.map { $0.notificationID! }
    }
}
