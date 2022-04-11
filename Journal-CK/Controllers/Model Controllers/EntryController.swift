//
//  EntryController.swift
//  Journal-CK
//
//  Created by Andrew Elliott on 4/11/22.
//

import CloudKit

class EntryController {
    
    // MARK: - Properties
    
    static let shared = EntryController()
    var entries: [Entry] = []
    let privateDB = CKContainer.default().privateCloudDatabase
    
    // MARK: - CRUD Functions
    
    func createEntry(title: String, body: String, completion: @escaping (_ result: Result<Entry?, EntryError>) -> Void) {
        let newEntry = Entry(title: title, body: body)
        
        save(entry: newEntry, completion: completion)
    }
    
    func save(entry: Entry, completion: @escaping (_ result: Result<Entry?, EntryError>) -> Void) {
        let ckRecord = CKRecord(entry: entry)
        privateDB.save(ckRecord) { record, error in
            if let error = error {
                // handle error
                completion(.failure(.thrownError(error)))
            } else {
                guard let record = record,
                      let savedEntry = Entry(ckRecord: record) else { return }
                self.entries.append(savedEntry)
                completion(.success(savedEntry))
            }
        }
    }
    
    func fetchEntries(completion: @escaping (_ result: Result<[Entry]?, EntryError>) -> Void) {
        let query = CKQuery(recordType: EntryConstants.RecordType, predicate: NSPredicate(value: true))
        privateDB.perform(query, inZoneWith: nil) { records, error in
            if let error = error {
                // handle error
                completion(.failure(.thrownError(error)))
            } else {
                guard let records = records else { return completion(.failure(.noData)) }
                
                let entries = records.compactMap { record in
                    return Entry(ckRecord: record)
                }
                
                self.entries = entries
                completion(.success(entries))
            }
        }
    }
    
}
