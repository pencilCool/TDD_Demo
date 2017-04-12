//
//  LocationTests.swift
//  LocationTests
//
//  Created by tangyuhua on 2017/4/10.
//  Copyright © 2017年 tangyuhua. All rights reserved.
//

import XCTest
import CoreLocation

@testable import TDD
class LocationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testInit_ShouldSetNameAndCoordinate() {
        let testCoordinate = CLLocationCoordinate2D(latitude: 1,
                                                    longitude: 2)
        let location = Location(name: "",coordinate:testCoordinate)
        XCTAssertEqual(location.coordinate?.latitude,
                       testCoordinate.latitude,
                       "Initializer should set latitude")
        XCTAssertEqual(location.coordinate?.longitude,
                       testCoordinate.longitude,
                       "Initializer should set longitude")
    }
    
    
    func testInit_ShouldSetName() {
        let location = Location(name: "Test name")
        XCTAssertEqual(location.name, "Test name",
                       "Initializer should set the name")
    }
    
    
    func testEqualLocations_ShouldBeEqual() {
        let firstLocation = Location(name: "Home")
        let secondLoacation = Location(name: "Home")
        XCTAssertEqual(firstLocation, secondLoacation)
    }

    func testWhenLatitudeDifferes_ShouldBeNotEqual() {
        performNotEqualTestWithLocationProperties(firstName: "Home",
                                                  secondName: "Home",
                                                  firstLongLat: (1.0, 0.0),
                                                  secondLongLat: (0.0, 0.0)
                                            )
    }
    func testWhenLongitudeDifferes_ShouldBeNotEqual() {
        func testWhenLongitudeDifferes_ShouldBeNotEqual() {
            performNotEqualTestWithLocationProperties(firstName: "Home",secondName: "Home", firstLongLat: (0.0, 1.0),
                  secondLongLat: (0.0, 0.0))
        }

    }
    
    func testWhenOneHasCoordinateAndTheOtherDoesnt_ShouldBeNotEqual() {
        performNotEqualTestWithLocationProperties(firstName: "Home",
                                                  secondName: "Home",
                                                  firstLongLat: (0.0, 0.0),
                                                  secondLongLat: nil)
    }

    func testWhenNameDifferes_ShouldBeNotEqual() {
        performNotEqualTestWithLocationProperties(firstName: "Home",
                                                  secondName: "Office",
                                                  firstLongLat: nil,
                                                  secondLongLat: nil)
    }
    
    func testWhenOneLocationIsNilAndTheOtherIsnt_ShouldBeNotEqual() {
        let firstItem = ToDoItem(title: "First title",
                                 itemDescription: "First description",
                                 timestamp: 0.0,
                                 location: nil)
        let secondItem = ToDoItem(title: "First title",
                                  itemDescription: "First description",
                                  timestamp: 0.0,
                                  location: Location(name: "Office"))
        XCTAssertNotEqual(firstItem, secondItem)
    }

    
    func testWhenTimestampDifferes_ShouldBeNotEqual() {
        let firstItem = ToDoItem(title: "First title",
                                 itemDescription: "First description",
                                 timestamp: 1.0)
        let secondItem = ToDoItem(title: "First title",
                                  itemDescription: "First description",
                                  timestamp: 0.0)
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    
    
    func performNotEqualTestWithLocationProperties(firstName: String,
                                                   secondName: String,
                                                   firstLongLat: (Double, Double)?,
                                                   secondLongLat: (Double, Double)?,
                                                    line: UInt = #line) {
        let firstCoord: CLLocationCoordinate2D?
        if let firstLongLat = firstLongLat {
            
            firstCoord = CLLocationCoordinate2D(
                latitude: firstLongLat.0,
                longitude: firstLongLat.1)
        } else {
            firstCoord = nil
        }
        let firstLocation = Location(name: firstName,
                                     coordinate: firstCoord)
        let secondCoord: CLLocationCoordinate2D?
        if let secondLongLat = secondLongLat {
            secondCoord = CLLocationCoordinate2D(
                latitude: secondLongLat.0,
                longitude: secondLongLat.1)
        } else {
            secondCoord = nil
        }
        let secondLocation = Location(name: secondName,
                                      coordinate: secondCoord)
        XCTAssertNotEqual(firstLocation, secondLocation)
        
    }

    func test_CanBeSerializedAndDeserialized() {
        let location = Location(name: "Home",
                                coordinate: CLLocationCoordinate2DMake(50.0, 6.0))
        let dict = location.plistDict
        
         XCTAssertNotNil(dict)
        let recreatedLocation = Location(dict: dict)
        XCTAssertEqual(location, recreatedLocation)
        
    }

    
}
