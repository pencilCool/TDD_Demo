//
//  ItemManager.swift
//  TDD
//
//  Created by tangyuhua on 2017/4/10.
//  Copyright © 2017年 tangyuhua. All rights reserved.
//

import Foundation


class ItemManager: NSObject {
    
    var toDoCount: Int { return toDoItems.count }
    var doneCount: Int { return doneItems.count }

    private var toDoItems = [ToDoItem]()
    private var doneItems = [ToDoItem]()
    
    var toDoPathURL: URL {
        let fileURLs = FileManager.default.urls(
            for: .documentDirectory, in: .userDomainMask)
        guard let documentURL = fileURLs.first else {
            print("Something went wrong. Documents url could not be found")
                fatalError()
        }
        return documentURL.appendingPathComponent("toDoItems.plist")
    }
    
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: Selector(("save")), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        save()
    }
    
    
    func addItem(_ item: ToDoItem) {
        
        if !toDoItems.contains(item) {
            toDoItems.append(item)
        }
        
    }
    
    func itemAtIndex(_ index: Int) -> ToDoItem {
        return toDoItems[index]
    }
    
    func checkItemAtIndex(_ index: Int) {
        
        let item = toDoItems.remove(at: index)
        doneItems.append(item)
  
    }
    
    func uncheckItemAtIndex(_ index: Int) {
        let item = doneItems.remove(at: index)
        toDoItems.append(item)
    }
    
    func doneItemAtIndex(_ index: Int) -> ToDoItem {
         return doneItems[index]
    }

    func removeAllItems() {
        
        toDoItems.removeAll()
        doneItems.removeAll()
    }

    
    func save() {
        var nsToDoItems = [AnyObject]()
        for item in toDoItems {
            nsToDoItems.append(item.plistDict)
        }
        if nsToDoItems.count > 0 {
            (nsToDoItems as NSArray).write(to: toDoPathURL,
                                                atomically: true)
        } else {
            
            do {
                try FileManager.default.removeItem(at: toDoPathURL)
            } catch {
                print(error)
            }
        }
    }
    

    
    
}
