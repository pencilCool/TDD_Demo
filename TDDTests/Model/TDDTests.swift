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
    var viewController: demo!
    override func setUp() {
        super.setUp()
        viewController = demo()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNumberOfVowelsInString_ShouldReturnNumberOfVowels() {
        
        let string = "Dominik"
        let numberOfVowels = viewController.numberOfVowelsInString(string: string)
        XCTAssertEqual(numberOfVowels, 3, "should find 3 vowels in Dominik",
                       file: "FirstDemoTests.swift", line: 24)
    }
    
    func testSyntaxDemo (){
          XCTAssertEqual(2, 1+1, "2 should be the same as 1+1")
          XCTAssertTrue(2 == 1+1, "2 should be the same as 1+1")
        
    }
    
     func testMakeHeadline_ReturnsStringWithEachWordStartCapital() {
    
        let inputString =       "this is A test headline"
        let expectedHeadline =  "This Is A Test Headline"
        
        let result = viewController.makeHeadline(string: inputString)
        XCTAssertEqual(result, expectedHeadline)
        
    }
    
    func testMakeHeadline_ReturnsStringWithEachWordStartCapital2() {
        let inputString =       "Here is another Example"
        let expectedHeadline =  "Here Is Another Example"
        let result = viewController.makeHeadline(string: inputString)
        XCTAssertEqual(result, expectedHeadline)
    }

    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
