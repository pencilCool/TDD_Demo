//
//  InputViewControllerTests.swift
//  TDD
//
//  Created by tangyuhua on 2017/4/11.
//  Copyright © 2017年 tangyuhua. All rights reserved.
//

import XCTest
import CoreLocation

@testable import TDD
class InputViewControllerTests: XCTestCase {
    var sut: InputViewController!
    
    var placemark: MockPlacemark!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        sut = storyboard.instantiateViewController(
            withIdentifier: "InputViewController") as! InputViewController
        _ = sut.view
    }
    
    override func tearDown() {
   
        super.tearDown()
    }
    
    func test_HasTitleTextField() {
        XCTAssertNotNil(sut.titleTextField)
    }
    
    
    func testSave_UsesGeocoderToGetCoordinateFromAddress() {
        sut.titleTextField.text = "Test Title"
        sut.dateTextField.text = "02/22/2016"
        sut.locationTextField.text = "Office"
        sut.addressTextField.text = "Infinite Loop 1, Cupertino"
        sut.descriptionTextField.text = "Test Description"
        let mockGeocoder = MockGeocoder()
        sut.geocoder = mockGeocoder
        sut.itemManager = ItemManager()
        sut.save()
        placemark = MockPlacemark()
        let coordinate = CLLocationCoordinate2DMake(37.3316851,
                                                    -122.0300674)
        placemark.mockCoordinate = coordinate
        mockGeocoder.completionHandler?([placemark], nil)
        let item = sut.itemManager?.itemAtIndex(0)
        let testItem = ToDoItem(title: "Test Title",
                                itemDescription: "Test Description",
                                timestamp: 1456095600,
                                location: Location(name: "Office", coordinate: coordinate))
        XCTAssertEqual(item, testItem)
    }

    
}



extension InputViewControllerTests {
    class MockGeocoder: CLGeocoder {
        var completionHandler: CLGeocodeCompletionHandler?
        
        override func geocodeAddressString(_ addressString: String,
                                           completionHandler: @escaping CLGeocodeCompletionHandler) {
            self.completionHandler = completionHandler
        }
    } }


class MockPlacemark : CLPlacemark {
    var mockCoordinate: CLLocationCoordinate2D?
    override var location: CLLocation? {
        guard let coordinate = mockCoordinate else { return CLLocation() }
        return CLLocation(latitude: coordinate.latitude,
                          longitude: coordinate.longitude)
    } }



