//
//  Entry.swift
//  Journal_Challenge
//
//  Created by Diego Aguirre on 4/8/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation

class Entry: Equatable {
    
    private let kTitle = "title"
    private let kBody = "body"
    private let kDate = "date"
    
    var title: String
    var body: String
    var date: NSDate
    
    var dictionaryCopy: [String: AnyObject] {
        return [kTitle: title, kBody: body, kDate: date]
    }
    
    init(title: String, body: String, date: NSDate) {
        self.title = title
        self.body = body
        self.date = date
    }
    
    init?(dictionary: [String: AnyObject]) {
        guard let title = dictionary[kTitle] as? String,
            body = dictionary[kBody] as? String,
            date = dictionary[kDate] as? NSDate else { return nil }
        
        self.title = title
        self.body = body
        self.date = date
    }
}

func ==(lhs: Entry, rhs: Entry) -> Bool {
    return (lhs.title == rhs.title) && (lhs.body == rhs.body) && (lhs.date == rhs.date)
}
