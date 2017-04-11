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
        sut.dateTextField.text = "11/04/2017"
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
                                timestamp: 1509724800,
                                location: Location(name: "Office", coordinate: coordinate))
        XCTAssertEqual(item, testItem)
    }
    
    
    func test_SaveButtonHasSaveAction() {
        let saveButton: UIButton = sut.saveButton
        guard let actions = saveButton.actions(forTarget: sut,
                                                        forControlEvent: .touchUpInside) else {
                                                            XCTFail(); return
        }
        XCTAssertTrue(actions.contains("save"))
    }
    
    
    func test_GeocoderWorksAsExpected() {
       
        let ex = expectation(description: "Wait for geocode")
        CLGeocoder().geocodeAddressString("北京") {
            (placemarks, error) -> Void in
            let placemark = placemarks?.first
            let coordinate = placemark?.location?.coordinate
            guard let latitude = coordinate?.latitude else {
                XCTFail()
                return }
            guard let longitude = coordinate?.longitude else {
                XCTFail()
                return }
            XCTAssertEqualWithAccuracy(latitude, 39.904989,
                                       accuracy: 0.000001)
            XCTAssertEqualWithAccuracy(longitude, 116.405285,
                                       accuracy: 0.000001)
            
            
            ex.fulfill()
        }
        
         waitForExpectations(timeout: 3, handler: nil)
    }
    
    
    func testSave_DismissesViewController() {
        let mockInputViewController = MockInputViewController()
        mockInputViewController.titleTextField = UITextField()
        mockInputViewController.dateTextField = UITextField()
        mockInputViewController.locationTextField = UITextField()
        mockInputViewController.addressTextField = UITextField()
        mockInputViewController.descriptionTextField = UITextField()
        mockInputViewController.titleTextField.text = "Test Title"
        mockInputViewController.save()
        XCTAssertTrue(mockInputViewController.dismissGotCalled)
    }
    
  

    
    
    
    

    
}



extension InputViewControllerTests {
    class MockGeocoder: CLGeocoder {
        var completionHandler: CLGeocodeCompletionHandler?
        
        override func geocodeAddressString(_ addressString: String,
                                           completionHandler: @escaping CLGeocodeCompletionHandler) {
            self.completionHandler = completionHandler
        }
    }


    
    class MockPlacemark : CLPlacemark {
        var mockCoordinate: CLLocationCoordinate2D?
        override var location: CLLocation? {
            guard let coordinate = mockCoordinate else { return CLLocation() }
            return CLLocation(latitude: coordinate.latitude,
                              longitude: coordinate.longitude)
        }
        
        
    }
    
    class MockInputViewController : InputViewController {
        var dismissGotCalled = false
        override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
            dismissGotCalled = true
            
        }
        
    }



}






