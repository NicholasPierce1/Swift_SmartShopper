//
//  AdminTests.swift
//  SmartShopperTests
//
//  Created by vamshi raj on 4/18/19.
//  Copyright © 2019 SmartShopperTeam. All rights reserved.
//

import XCTest

class AdminTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddAdmin() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let userName = "user"
        let password = "password"
        let storeNumber = 404
        let storePassword = 404
        let newAdmin = Store.shared.addAdmin(withUsername: userName, adminPassword: password, forStore: storeNumber, storePassword: storePassword)
        
        //using ReturnCode for assertion
        XCTAssertTrue(newAdmin == ReturnCode.adminAdded)
        
    }
    
    //Test if an already existing admin is beign created again
    func testAdminLoginSuccess() {
        let userName = "user"
        let password = "password"
        let storeNumber = 404
        let storePassword = 404
        //Creating an admin
        let _ = Store.shared.addAdmin(withUsername: userName, adminPassword: password, forStore: storeNumber, storePassword: storePassword)
        
        XCTAssertTrue(Store.shared.login(username: userName, adminPassword: password, storePassword: storePassword))
    }
    
    func testAdminLoginFailed() {
        let userName = "user"
        let password = "password"
        let storePassword = 404
        //Testing without creating an admin
        XCTAssertFalse(Store.shared.login(username: userName, adminPassword: password, storePassword: storePassword))
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
