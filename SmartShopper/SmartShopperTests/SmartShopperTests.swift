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
    
    // enumerates local variables that contain initial, model data
    
    // holds all departments
    private static let departmentList : [Department] = [Department(name: "Grocery", minAisleNum: 4, maxAisleNum: 10), Department(name: "HBC", minAisleNum: 2, maxAisleNum: 4), Department(name: "Seasonal", minAisleNum: 1, maxAisleNum: 1), Department(name: "Meat", minAisleNum: -1, maxAisleNum: -1), Department(name: "Deli", minAisleNum: -1, maxAisleNum: -1), Department(name: "Bakery", minAisleNum: -1, maxAisleNum: -1), Department(name: "Produce", minAisleNum: -1, maxAisleNum: -1), Department(name: "Floral", minAisleNum: -1, maxAisleNum: -1), Department(name: "Frozen/Dairy", minAisleNum: -1, maxAisleNum: -1)]
    
    // holds all items corresponding to the department
    private static var store: [Department: [String: Item]] = [
        departmentList[0]: ["024100122332": Item.createItem(name: "Cheez-Its", categoryName: "Crackers", vendor: "Sunshine", barcode: "024100122332", aisleNum: 5), "180855000032": Item.createItem(name: "Mild Black Bean & Corn Salsa", categoryName: "Salsa", vendor: "My Brother's Salsa", barcode: "180855000032", aisleNum: 6)],
        departmentList[1] : ["011132135973": Item.createItem(name: "Alpo 13.2 Ounce T Bone Dog Food", categoryName: "Dog Food", vendor: "Purina", barcode: "011132135973", aisleNum: 3),"8718114326931": Item.createItem(name: "Alaska Deodorant Body Spray", categoryName: "Body Spray", vendor: "Axe", barcode: "8718114326931", aisleNum: 2)],
        departmentList[2]: ["034613025631": Item.createItem(name: "Stars & Stripes Citro Candle", categoryName: "Candle", vendor: "Seasonal Trends", barcode: "034613025631", aisleNum: 1), "670171112330": Item.createItem(name: "White Cheddar", categoryName: "Popcorn", vendor: "Kernel Season's", barcode: "670171112330", aisleNum: 1)],
        departmentList[3]: ["799418002507": Item.createItem(name: "Chicago's Finest Filet Mignon, Boneless", categoryName: "Steak", vendor: "Chicago Steak Company", barcode: "799418002507", aisleNum: nil), "077782008135": Item.createItem(name: "Italian Sausage", categoryName: "Sausage", vendor: "Johnsonville", barcode: "077782008135", aisleNum: nil)],
        departmentList[4]: ["023700103093": Item.createItem(name: "Boneless Wings", categoryName: "Wings", vendor: "Deli Prepared", barcode: "023700103093", aisleNum: nil), "024508042263": Item.createItem(name: "Henri Hutin Valbrie 60% Cheese 7.00 oz", categoryName: "cheese", vendor: "Imported Deli Cheese", barcode: "024508042263", aisleNum: nil)],
        departmentList[5]: ["028143014470": Item.createItem(name: "White And Dark Choclate Mousse Cake", categoryName: "Cake", vendor: "Lawlers Dessert", barcode: "028143014470", aisleNum: nil),"028143256115": Item.createItem(name: "Fluted Bourbon Pecan Pie", categoryName: "Pies", vendor: "Lawlers Dessert", barcode: "028143256115", aisleNum: nil)],
        departmentList[6]: ["033383001531": Item.createItem(name: "Granny Smith 3lb Bag", categoryName: "Apples", vendor: "Bagged Apples", barcode: "033383001531", aisleNum: nil), "045255130300": Item.createItem(name: "Dried Banana Chips", categoryName: "Bananas", vendor: "Melissa's", barcode: "045255130300", aisleNum: nil)],
        departmentList[7]: ["190033598152": Item.createItem(name: "Ceramic Flower Pot", categoryName: "Flower Pots", vendor: "Outgeek Bonsai", barcode: "190033598152", aisleNum: nil), "033849573510": Item.createItem(name: "28-in. Artificial Rose", categoryName: "Flowers", vendor: "Allstate Floral", barcode: "033849573510", aisleNum: nil)],
        departmentList[8]: ["820103680561": Item.createItem(name: "Organic 2% Lowfat Choclate Milk", categoryName: "Milk", vendor: "Kirkland", barcode: "820103680561", aisleNum: nil), "077567254238": Item.createItem(name: "Natural Vanilla Ice Cream", categoryName: "Ice Cream", vendor: "Breyers", barcode: "077567254238", aisleNum: nil)]]


    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // holds premodified copy
        let premodified: Int = Tester.testVar
        
        // amends value of testerVar
        Tester.testVarAddOne(&Tester.testVar)
        
        // asserts equalaity between the two instances
        XCTAssertEqual(Tester.testVar, premodified )
        
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//            //print(Stores.shared)
//        }
//    }

}

private struct Tester{
    fileprivate static var testVar: Int = 3
    
    fileprivate static func testVarAddOne(_ testVar:inout Int) -> Void {
        testVar += 1
    }
}
