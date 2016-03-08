/*

public extension CollectionType where Generator.Element : ORLiftEntry {

    var sortedByDate: [ORLiftEntry] {
        return self.sort { $0.date.isBefore(date: $1.date) }
    }

    var sortedByReverseDate: [ORLiftEntry] {
        return self.sort { !$0.date.isBefore(date: $1.date) }
    }
}

public extension CollectionType where Generator.Element : ORModel {

    var records: [CKRecord] {
        return map { $0.record }
    }

    var references: [CKReference] {
        return map { $0.reference }
    }
}

public extension CollectionType where Generator.Element : ORModel {

    var recordNames: [String] { return map { $0.recordName } }
}

public extension CKRecord {
    
    func modelForName(name: String) -> ORModel? {
        guard let reference = self.valueForKey(name) as? CKReference else { return nil }
        return self.modelFromReference(reference)
    }
    
    func modelListForName(name: String) -> [ORModel]? {
        guard let references = self.valueForKey(name) as? [CKReference] else { return nil }
        return self.modelListFromReferences(references)
    }
    
    func modelFromReference(reference: CKReference) -> ORModel? {
        return ORSession.currentSession.localData.fetchObject(id: reference.recordID.recordName, model: ORModel.self)
    }
    
    func modelListFromReferences(references: [CKReference]) -> [ORModel]? {
        let recordNames = references.recordIDs.recordNames
        return ORSession.currentSession.localData.fetchObjects(ids: recordNames, model: ORModel.self, context: NSManagedObjectContext.contextForCurrentThread())
    }
    
}

*/