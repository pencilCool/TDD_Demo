//
//  ItemListViewControllerTests.swift
//  TDD
//
//  Created by tangyuhua on 2017/4/10.
//  Copyright © 2017年 tangyuhua. All rights reserved.
//

import XCTest
@testable import TDD
class ItemListViewControllerTests: XCTestCase {
    var sut: ItemListViewController!
    var inputViewController :InputViewController!
    var mockTableView: MockTableView!
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
        _ = sut.view
        UIApplication.shared.keyWindow?.rootViewController = sut
        
        XCTAssertNil(sut.presentedViewController)
        guard let addButton = sut.navigationItem.rightBarButtonItem else
        { XCTFail(); return }
        
        sut.perform(addButton.action!, with: addButton)
        XCTAssertNotNil(sut.presentedViewController)
        XCTAssertTrue(sut.presentedViewController is InputViewController)
        inputViewController = sut.presentedViewController as!
        InputViewController
        
        
        mockTableView = MockTableView(frame: CGRect(x: 10, y: 10, width: 10, height: 10), style: .plain)
    
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_TableViewIsNotNilAfterViewDidLoad() {

            XCTAssertNotNil(sut.tableView)
         XCTAssertTrue(sut.tableView.dataSource is ItemListDataProvider)
    }
    
    
    func testViewDidLoad_ShouldSetTableViewDelegate() {
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertTrue(sut.tableView.delegate is ItemListDataProvider)
    }
    
    
    func testViewDidLoad_ShouldSetDelegateAndDataSourceToTheSameObject() {
        XCTAssertEqual(sut.tableView.dataSource as? ItemListDataProvider,
                       sut.tableView.delegate as? ItemListDataProvider)
    }
    
    func testItemListViewController_HasAddBarButtonWithSelfAsTarget() {
        XCTAssertEqual(sut.navigationItem.rightBarButtonItem?.target as? UIViewController,
                       sut)
    }
    
    
    func testAddItem_PresentsAddItemViewController() {

        XCTAssertNotNil(inputViewController.titleTextField)
        
        
    }
 
    
    func testItemListVC_SharesItemManagerWithInputVC() {

        guard let inputItemManager = inputViewController.itemManager else { XCTFail(); return }
        XCTAssertTrue(sut.itemManager === inputItemManager)
    }
    
    func testViewDidLoad_SetsItemManagerToDataProvider() {
        XCTAssertTrue(sut.itemManager === sut.dataProvider.itemManager)
    }
    
    
    //FIXME: TEST SHOULD PASSED
    func testTableViewReload_whenItemManagerChanged() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
        sut.tableView = mockTableView
        _ = sut.view
        sut.itemManager.addItem(ToDoItem(title: "First"))
        
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
       // XCTAssertTrue(mockTableView.tableViewReload)

    }
    
    
    func testItemSelectedNotification_PushesDetailVC() {
        let mockNavigationController = MockNavigationController(rootViewController: sut)
        UIApplication.shared.keyWindow?.rootViewController =
        mockNavigationController
        _ = sut.view
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ItemSelectedNotification"), object: self, userInfo: ["index": 1])
        guard let detailViewController = mockNavigationController.pushedViewController as? DetailViewController else { XCTFail(); return
        }
        guard let detailItemManager = detailViewController.itemInfo?.0
        else
       { XCTFail(); return }
        
       guard let index = detailViewController.itemInfo?.1 else
       { XCTFail(); return }
        
       _ = detailViewController.view
       XCTAssertNotNil(detailViewController.titleLabel)
       XCTAssertTrue(detailItemManager === sut.itemManager)
       XCTAssertEqual(index, 1)
}

        
        

}

class MockNavigationController : UINavigationController {
    var pushedViewController: UIViewController?
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: animated)
    }
}



extension ItemListViewControllerTests {
    

    
    class MockTableView : UITableView {
        var tableViewReload = false
        override func reloadData() {
            tableViewReload = true
        }
       
    }
    
    class func mockTableViewWithDataSource(
        _ dataSource: UITableViewDataSource) -> MockTableView {
        let mockTableView = MockTableView(
            frame: CGRect(x: 0, y: 0, width: 320, height: 480),
            style: .plain)
        mockTableView.dataSource = dataSource
        mockTableView.register(ItemCell.self, forCellReuseIdentifier:"ItemCell")
        return mockTableView
    }

}

