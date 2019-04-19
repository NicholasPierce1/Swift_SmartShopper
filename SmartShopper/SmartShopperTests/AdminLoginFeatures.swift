//
//  AdminTests.swift
//  SmartShopperTests
//
//  Created by vamshi raj on 4/18/19.
//  Copyright © 2019 SmartShopperTeam. All rights reserved.
//

import XCTest

class AdminLoginFeatures: XCTestCase {
    
    // holds local data of Admin
    private static let adminList: [Admin] = [Admin(userName: "Kevin Norris", adminPassword: "404", storeNumForAdmin: 404), Admin(userName: "Nick Pierce", adminPassword: "919359263", storeNumForAdmin: 123)]
    
    // holds local data for store: password matchup
    private static let storePasswordAndNum: [Int : Int] = [404: 404, 123: 123, 987: 987]

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
//
//    func testAddAdmin() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        let userName = "user"
//        let password = "password"
//        let storePassword = 404
//        let storeNumber = AdminLoginFeatures.storePasswordAndNum[storePassword]!
//        let newAdmin = Store.shared.addAdmin(withUsername: userName, adminPassword: password, forStore: storeNumber, storePassword: storePassword)
//        
//        
//        //using ReturnCode for assertion
//        XCTAssertTrue(newAdmin == ReturnCode.adminAdded)
//        
//    }
    
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
        let userName = "user1"
        let password = "password1"
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
