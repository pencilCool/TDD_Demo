//
//  APIClientTests.swift
//  TDD
//
//  Created by tangyuhua on 2017/4/11.
//  Copyright © 2017年 tangyuhua. All rights reserved.
//

import XCTest
@testable import TDD

class APIClientTests: XCTestCase {
    
    
    var sut: APIClient!
    var mockURLSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        sut = APIClient()
        mockURLSession = MockURLSession()
        sut.session = mockURLSession
    }
    
    override func tearDown() {
        super.tearDown()
    }
    func testLogin_MakesRequestWithUsernameAndPassword() {

        let completion = { (error: Error?) in }
        sut.loginUserWithName(username: "dasdom",
                              password: "1234",
                              completion: completion)
        
        XCTAssertNotNil(mockURLSession.completionHandler)
        
        guard let url = mockURLSession.url else { XCTFail(); return }
        let urlComponents = URLComponents(url: url,
                                            resolvingAgainstBaseURL: true)
        XCTAssertEqual(urlComponents?.host, "awesometodos.com")
        XCTAssertEqual(urlComponents?.path, "/login")
        XCTAssertEqual(urlComponents?.query,
                       "username=dasdom&password=1234")

    }
    
    func testLogin_CallsResumeOfDataTask() {

        let completion = { (error: Error?) in }
        sut.loginUserWithName(username: "dasdom",
                              password: "1234",
                              completion: completion)
        XCTAssertTrue(mockURLSession.dataTask.resumeGotCalled)
    }
    
    func testLogin_SetsToken() {
        let mockKeychainManager = MockKeychainMananger()
        sut.keychainManager = mockKeychainManager
        let completion = { (error: Error?) in }
        sut.loginUserWithName(username: "dasdom",
                              password: "1234",
                              completion: completion)
        let responseDict = ["token" : "1234567890"]
        let responseData = try!JSONSerialization.data(withJSONObject: responseDict, options: [])
        mockURLSession.completionHandler?(responseData, nil, nil)
        let token = mockKeychainManager.passwordForAccount(account: "token")
        XCTAssertEqual(token, responseDict["token"])
    }
    
    
    func testLogin_ThrowsErrorWhenJSONIsInvalid() {
        var theError: Error?
        let completion = { (error: Error?) in
            theError = error
        }
        sut.loginUserWithName(username: "dasdom",
                              password: "1234",
                              completion: completion)
        let responseData = NSData()
        mockURLSession.completionHandler?(responseData as Data, nil, nil)
        XCTAssertNotNil(theError)
    }
    
    
    func testLogin_ThrowsErrorWhenDataIsNil() {
        
        var theError: Error?
        let completion = { (error: Error?) in
            theError = error
        }
        sut.loginUserWithName(username: "dasdom",
                              password: "1234",
                              completion: completion)
        mockURLSession.completionHandler?(nil, nil, nil)
        XCTAssertNotNil(theError)
        
    }
    
    func testLogin_ThrowsErrorWhenResponseHasError() {
        
        var theError: Error?
        let completion = { (error: Error?) in
            theError = error
        }
        sut.loginUserWithName(username: "dasdom",
                              password: "1234",
                              completion: completion)
        let responseDict = ["token" : "1234567890"]
        let responseData = try! JSONSerialization.data(withJSONObject: responseDict,
            options: [])
        
        let error = NSError(domain: "SomeError", code:
            1234, userInfo: nil)
        mockURLSession.completionHandler?(responseData, nil, error)
        XCTAssertNotNil(theError)
        
    }
        
        
        
    
    

}


extension APIClientTests {
    class MockURLSession : ToDoURLSession{
        typealias Handler = (Data?, URLResponse?, NSError?)
            -> Void
        var completionHandler: Handler?
        var url: URL?
        var dataTask = MockURLSessionDataTask()
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask {
            self.url = url
            self.completionHandler = completionHandler
            return dataTask
        }
    }
    
    class MockURLSessionDataTask : URLSessionDataTask {
        var resumeGotCalled = false
        override func resume() {
            resumeGotCalled = true
        }
    }
    
    class MockKeychainMananger : KeychainAccessible {
        var passwordDict = [String:String]()
        func setPassword(password: String,
                         account: String) {
            passwordDict[account] = password
        }
        func deletePasswortForAccount(account: String) {
            passwordDict.removeValue(forKey: account)
        }
        func passwordForAccount(account: String) -> String? {
            return passwordDict[account]
        }
    }
    

    
    
}
