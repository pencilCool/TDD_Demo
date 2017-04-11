//
//  ItemCellTests.swift
//  TDD
//
//  Created by tangyuhua on 2017/4/10.
//  Copyright © 2017年 tangyuhua. All rights reserved.
//

import XCTest
@testable import TDD
class ItemCellTests: XCTestCase {
    var tableView: UITableView?
    let dataProvider = FakeDataSource()
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as!ItemListViewController
        _ = controller.view
        
        tableView = controller.tableView
 
        tableView?.dataSource = dataProvider
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testSUT_HasNameLabel() {

        let indexPath = IndexPath(row: 0, section: 0)
        
        let cell = tableView?.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell

        XCTAssertNotNil(cell.titleLabel)
        
        
    }
    
    func testSUT_HasLocationLabel() {
    
        let indexPath = IndexPath(row: 0, section: 0)
        
        let cell = tableView?.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        XCTAssertNotNil(cell.locationLabel)
    }
    
    
    func testConfigWithItem_SetsTitle() {
        
        let indexPath = IndexPath(row: 0, section: 0)
        
        
      let cell = tableView?.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        cell.configCellWithItem(ToDoItem(title: "First"))
        XCTAssertEqual(cell.titleLabel.text, "First")
    }
    
    
    func testConfigWithItem_SetsLabelTexts() {
        
        
        let indexPath = IndexPath(row: 0, section: 0)
        
       let cell = tableView?.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        cell.configCellWithItem(ToDoItem(title: "First", itemDescription:
            nil, timestamp: 1456150025, location: Location(name: "Home")))
        XCTAssertEqual(cell.titleLabel.text, "First")
        XCTAssertEqual(cell.locationLabel.text, "Home")
        XCTAssertEqual(cell.dateLabel.text, "02/22/2016")
    }
    
    
    func testTitle_ForCheckedTasks_IsStrokeThrough() {
        let indexPath = IndexPath(row: 0, section: 0)
        
        let cell = tableView?.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        let toDoItem = ToDoItem(title: "First",
                                itemDescription: nil,
                                timestamp: 1456150025,
                                location: Location(name: "Home"))
        cell.configCellWithItem(toDoItem, checked: true)
        let attributedString = NSAttributedString(string: "First",
                                                  attributes: [NSStrikethroughStyleAttributeName:
                                                    NSUnderlineStyle.styleSingle.rawValue])
        XCTAssertEqual(cell.titleLabel.attributedText, attributedString)
        XCTAssertNil(cell.locationLabel.text)
        XCTAssertNil(cell.dateLabel.text)
    }
    
    
}

extension ItemCellTests {
    class FakeDataSource: NSObject, UITableViewDataSource {
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 2;
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 2
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
    
    
}
