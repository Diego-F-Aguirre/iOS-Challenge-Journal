//
//  EntryController.swift
//  Journal_Challenge
//
//  Created by Diego Aguirre on 4/8/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation

class EntryController {
    
    static let sharedInstance = EntryController()
    private let kEntries = "entries"
    static let userDefaults = NSUserDefaults.standardUserDefaults()
    var entryArray: [Entry] = []
    
    init() {
        self.loadToPersistentStorage()
    }
}

extension EntryController {
    func createEntry(title: String, body: String, date: NSDate) {
        let newEntry = Entry(title: title, body: body, date: date)
        entryArray.append(newEntry)
        self.saveToPersistentStorage()
    }
    
    func updateEntry(entry: Entry, newTitle: String, newBody: String, newDate: NSDate) {
        entry.title = newTitle
        entry.body = newBody
        entry.date = newDate
        
        entryArray.append(entry)
        self.saveToPersistentStorage()
    }
    
    func removeEntry(entry: Entry) {
        if let entryIndex = entryArray.indexOf(entry) {
            entryArray.removeAtIndex(entryIndex)
            self.saveToPersistentStorage()
        }
    }
}

extension EntryController {
    
    func saveToPersistentStorage() {
        var entryDictionaryArray: [[String: AnyObject]] = []
        
        for entry in entryArray {
            let entryDictionary = entry.dictionaryCopy
            entryDictionaryArray.append(entryDictionary)
        }
        EntryController.userDefaults.setObject(entryDictionaryArray, forKey: kEntries)
    }
    
    func loadToPersistentStorage() {
        
        guard let entryDictionaryArray = EntryController.userDefaults.objectForKey(kEntries) as? [[String: AnyObject]] else { return }
        
        var entriesArray: [Entry] = []
        
        for entryDictionary in entryDictionaryArray {
            if let entry = Entry.init(dictionary: entryDictionary) {
                entriesArray.append(entry)
            }
        }
        entryArray = entriesArray
    }
}









