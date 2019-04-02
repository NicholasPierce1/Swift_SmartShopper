//
//  SmartShopperTests.swift
//  SmartShopperTests
//
//  Created by Nick Pierce on 3/20/19.
//  Copyright © 2019 SmartShopperTeam. All rights reserved.
//

import XCTest
//@testable import SmartShopper

class SmartShopperTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //Store.shared.returnDepartments()
        //Department.departmentList
        tester.testVar = 5
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            //print(Stores.shared)
        }
    }

}

private struct tester{
    fileprivate static var testVar = 3
}
