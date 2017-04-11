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
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
        _ = sut.view
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
        XCTAssertNil(sut.presentedViewController)
        guard let addButton = sut.navigationItem.rightBarButtonItem else
        { XCTFail(); return }
        UIApplication.shared.keyWindow?.rootViewController = sut
        sut.perform(addButton.action!, with: addButton)
        XCTAssertNotNil(sut.presentedViewController)
        XCTAssertTrue(sut.presentedViewController is InputViewController)
        
        let inputViewController = sut.presentedViewController as!
        InputViewController
        XCTAssertNotNil(inputViewController.titleTextField)
        
        
    }
    
    

    
}

