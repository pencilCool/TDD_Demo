//
//  ItemListDataProviderTests.swift
//  TDD
//
//  Created by tangyuhua on 2017/4/10.
//  Copyright © 2017年 tangyuhua. All rights reserved.
//

import XCTest
@testable import TDD

class ItemListDataProviderTests: XCTestCase {
    
    var sut: ItemListDataProvider!
    var tableView: UITableView!
    
    var controller: ItemListViewController!
    
    
    override func setUp() {
        super.setUp()
        sut = ItemListDataProvider()
        sut.itemManager = ItemManager()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
            _ = controller.view
            tableView = controller.tableView
            tableView.dataSource = sut
            tableView.delegate = sut

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testNumberOfSections_IsTwo() {

        let numberOfSections = tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 2)
    }
    
    
    func testNumberRowsInFirstSection_IsToDoCount() {
    
        sut.itemManager?.addItem(ToDoItem(title: "First"))
            
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
            
        sut.itemManager?.addItem(ToDoItem(title: "Second"))
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
        
    }
    
    
    func testNumberRowsInSecondSection_IsDoneCount() {
        sut.itemManager?.addItem(ToDoItem(title: "First"))
        sut.itemManager?.addItem(ToDoItem(title: "Second"))
        sut.itemManager?.checkItemAtIndex(0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
        sut.itemManager?.checkItemAtIndex(0)
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
    }
    
    func testCellForRow_ReturnsItemCell() {
        sut.itemManager?.addItem(ToDoItem(title: "First"))
        tableView.reloadData()
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = tableView.cellForRow(at: indexPath)
        XCTAssertTrue(cell is ItemCell)
    }
    
    func testCellForRow_DequeuesCell() {
         let mockTableView = MockTableView.mockTableViewWithDataSource(sut)
        sut.itemManager?.addItem(ToDoItem(title: "First"))
        mockTableView.reloadData()
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(mockTableView.cellGotDequeued)
    }

    func testConfigCell_GetsCalledInCellForRow() {
        let mockTableView = MockTableView.mockTableViewWithDataSource(sut)
        
        let toDoItem = ToDoItem(title: "First",
                                itemDescription: "First description")
        sut.itemManager?.addItem(toDoItem)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockItemCell
        XCTAssertEqual(cell.toDoItem, toDoItem)
    }
    
    
    func testCellInSectionTwo_GetsConfiguredWithDoneItem() {
        let mockTableView = MockTableView.mockTableViewWithDataSource(sut)
 
        
        let firstItem = ToDoItem(title: "First",
                                 itemDescription: "First description")
        sut.itemManager?.addItem(firstItem)
        let secondItem = ToDoItem(title: "Second",
                                  itemDescription: "Second description")
        sut.itemManager?.addItem(secondItem)
        sut.itemManager?.checkItemAtIndex(1)
        
        mockTableView.reloadData()
 
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! MockItemCell
         XCTAssertEqual(cell.toDoItem, secondItem)
    }
    
    
    func testDeletionButtonInFirstSection_ShowsTitleCheck() {
        
        let indexPath = IndexPath(row: 0, section: 0)
        
        let deleteButtonTitle = tableView.delegate?.tableView!(tableView, titleForDeleteConfirmationButtonForRowAt : indexPath)

        XCTAssertEqual(deleteButtonTitle, "Check")

    }
    
    func testDeletionButtonInFirstSection_ShowsTitleUncheck() {
        let indexPath = IndexPath(row: 0, section: 1)
        
        let deleteButtonTitle = tableView.delegate?.tableView!(tableView, titleForDeleteConfirmationButtonForRowAt : indexPath)
        
        XCTAssertEqual(deleteButtonTitle, "Uncheck")

    }
    
    
    func testDataSourceAndDelegate_AreNotTheSameObject() {
        
        XCTAssert(tableView.dataSource is ItemListDataProvider)
        XCTAssert(tableView.delegate is ItemListDataProvider)
        XCTAssertEqual(tableView.dataSource as? ItemListDataProvider,
                          tableView.delegate as? ItemListDataProvider)
    }
    
    
    func testCheckingAnItem_ChecksItInTheItemManager() {
        
        
        sut.itemManager?.addItem(ToDoItem(title: "First"))


        let indexPath = IndexPath(row: 0, section: 0)
        tableView.dataSource?.tableView!(tableView, commit: .delete, forRowAt: indexPath)
        
        XCTAssertEqual(sut.itemManager?.toDoCount, 0)
        XCTAssertEqual(sut.itemManager?.doneCount, 1)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
    }
    
    func testUncheckingAnItem_UnchecksItInTheItemManager() {
        sut.itemManager?.addItem(ToDoItem(title: "First"))
        sut.itemManager?.checkItemAtIndex(0)
        tableView.reloadData()
        
        let indexPath = IndexPath(row: 0, section: 1)
        tableView.dataSource?.tableView!(tableView, commit: .delete, forRowAt: indexPath)
        
        XCTAssertEqual(sut.itemManager?.toDoCount, 1)
        XCTAssertEqual(sut.itemManager?.doneCount, 0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 0)

    }

}
    
    




extension ItemListDataProviderTests {
    class MockTableView : UITableView {
        var cellGotDequeued = false
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellGotDequeued = true
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
        
        class func mockTableViewWithDataSource(
            _ dataSource: UITableViewDataSource) -> MockTableView {
                let mockTableView = MockTableView(
                    frame: CGRect(x: 0, y: 0, width: 320, height: 480),
                    style: .plain)
                mockTableView.dataSource = dataSource
                mockTableView.register(MockItemCell.self, forCellReuseIdentifier:"ItemCell")
                return mockTableView
        }
    }
    
    class MockItemCell : ItemCell {

        var toDoItem: ToDoItem?

         override func configCellWithItem(_ item: ToDoItem, checked: Bool = false) {
        
             toDoItem = item
        }
    }
    
    

}

