//
//  ToDoItem.swift
//  TDD
//
//  Created by tangyuhua on 2017/4/10.
//  Copyright © 2017年 tangyuhua. All rights reserved.
//

import Foundation

struct ToDoItem:Equatable {
    let title: String
    let itemDescription: String?
    let timestamp: Double?
    let location: Location?
    

    
    init(title: String, itemDescription: String? = nil, timestamp: Double? = nil,location: Location? = nil) {
        self.title = title
        self.itemDescription = itemDescription
        self.timestamp = timestamp
        self.location = location
    }
    
    init?(dict: NSDictionary) {
        return nil
    }

    
    
    var plistDict: NSDictionary {
        return [:]

    }
    
    static func ==(lhs: ToDoItem, rhs: ToDoItem) -> Bool {
        
        
       if lhs.title != rhs.title {
            return false
        }

       if lhs.timestamp != rhs.timestamp {
            return false
        }
        
       if lhs.location != rhs.location {
            return false
        }
        
        
        if lhs.itemDescription != rhs.itemDescription {
            return false
        }

        return true
    }
    
}
