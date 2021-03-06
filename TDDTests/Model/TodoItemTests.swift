//
//  SecondChaterTest.swift
//  SecondChaterTest
//
//  Created by tangyuhua on 2017/4/10.
//  Copyright © 2017年 tangyuhua. All rights reserved.
//

import XCTest
@testable import   TDD
class ToDoItemTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
      
        super.tearDown()
    }
    

    
    func testInit_ShouldTakeTitle() {
        _ = ToDoItem(title: "Test title", itemDescription: nil)
       
    }
    
    
    func testInit_ShouldTakeTitleAndDescription() {
        let item = ToDoItem(title: "Test title",
                     itemDescription: "Test description")
        
        
        XCTAssertEqual(item.itemDescription , "Test description",
                       "Initializer should set the item description")
    }
    
    
    func testInit_ShouldSetTitleAndDescriptionAndTimestamp() {
        let item = ToDoItem(title: "Test title",
                            itemDescription: "Test description",
                            timestamp: 0.0)
        XCTAssertEqual(0.0, item.timestamp,
                       "Initializer should set the timestamp")
    }
    
    
    
    func testInit_ShouldSetTitleAndDescriptionAndTimestampAndLocation() {
        let location = Location(name: "Test name")
        let item = ToDoItem(title: "Test title",
                            itemDescription: "Test description",
                            timestamp: 0.0,
                            location: location)
        XCTAssertEqual(location.name, item.location?.name,
                       "Initializer should set the location")

    }

    
    func testEqualItems_ShouldBeEqual() {
        let firstItem = ToDoItem(title: "First")
        let secondItem = ToDoItem(title: "First")
        XCTAssertEqual(firstItem, secondItem)
    }
    
    func testWhenLocationDifferes_ShouldBeNotEqual() {
        let firstItem = ToDoItem(title: "First title",
                                 itemDescription: "First description", timestamp: 0.0,
                                 location: Location(name: "Home"))
        let secondItem = ToDoItem(title: "First title",
                                  itemDescription: "First description", timestamp: 0.0,
                                  location: Location(name: "Office"))
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    
    func testWhenDescriptionDifferes_ShouldBeNotEqual() {
        let firstItem = ToDoItem(title: "First title",
                                 itemDescription: "First description")
        let secondItem = ToDoItem(title: "First title",
                                  itemDescription: "Second description")
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func testWhenTitleDifferes_ShouldBeNotEqual() {
        let firstItem = ToDoItem(title: "First title")
        let secondItem = ToDoItem(title: "Second title")
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    
    func test_HasPlistDictionaryProperty() {
        let item = ToDoItem(title: "First")
        let dictionary = item.plistDict
        
        XCTAssertNotNil(dictionary)
        XCTAssertTrue(dictionary is NSDictionary)
        
    }
    
    func test_CanBeCreatedFromPlistDictionary() {
        let location = Location(name: "Home")
        let item = ToDoItem(title: "The Title",
                            itemDescription: "The Description",
                            timestamp: 1.0,
                            location: location)
        let dict = item.plistDict
        let recreatedItem = ToDoItem(dict: dict)
        XCTAssertEqual(item, recreatedItem)
    }
    

    
    
}
