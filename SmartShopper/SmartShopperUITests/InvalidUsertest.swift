//
//  InvalidUsertest.swift
//  SmartShopperUITests
//
//  Created by vamshi raj on 4/17/19.
//  Copyright © 2019 SmartShopperTeam. All rights reserved.
//

import XCTest

class InvalidUsertest: XCTestCase {
var app:XCUIApplication!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        app = XCUIApplication()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let loginTab = app.buttons["Login"]
        loginTab.tap()
                let userNameField = app.textFields["username"]
                userNameField.tap()
                userNameField.typeText("username")
                let passwordField = app.textFields["password"]
                passwordField.tap()
                passwordField.typeText("password")
                let storePassword = app.textFields["storePassword"]
                storePassword.tap()
                storePassword.typeText("404")
        let lognBtn = app.buttons["login"]
        lognBtn.tap()
        XCTAssertTrue(app.alerts["Login Failed"].waitForExistence(timeout: 1))
    }

}
