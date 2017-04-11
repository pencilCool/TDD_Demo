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


    
    
}
