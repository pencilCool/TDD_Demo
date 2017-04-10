//
//  TDDTests.swift
//  TDDTests
//
//  Created by tangyuhua on 2017/4/10.
//  Copyright © 2017年 tangyuhua. All rights reserved.
//

import XCTest
@testable import TDD

class TDDTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNumberOfVowelsInString_ShouldReturnNumberOfVowels() {
        let viewController = ViewController()
        let string = "Dominik"
        let numberOfVowels = viewController.numberOfVowelsInString(string: string)
        XCTAssertEqual(numberOfVowels, 3, "should find 3 vowels in Dominik")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
