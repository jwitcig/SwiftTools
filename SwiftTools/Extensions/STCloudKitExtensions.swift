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

    convenience init(recordType: String) {
        self.init(recordType: recordType, predicate: NSPredicate.allRows)
    }

}

public extension CKRecord {

    func propertyForName<T>(name: String, defaultValue: T) -> T {
        guard let storedValue = self.valueForKey(name) as? T else { return defaultValue }
        return storedValue
    }

    func referenceForName(name: String) -> CKReference? {
        return self[name] as? CKReference
    }

    func referencesForName(name: String) -> Set<CKReference> {
        let references = self[name] as? [CKReference]
        return references != nil ? Set(references!) : Set()
    }

}

public extension CollectionType where Generator.Element : CKRecord {

    var recordIDs: [CKRecordID] { return map { $0.recordID } }
}

public extension CollectionType where Generator.Element : CKRecordID {

    var recordNames: [String] { return map { $0.recordName } }
    var references: [CKReference] { return map { CKReference(recordID: $0, action: .None) } }
}

public extension CollectionType where Generator.Element : CKReference {

    var recordIDs: [CKRecordID] { return map { $0.recordID } }
}
