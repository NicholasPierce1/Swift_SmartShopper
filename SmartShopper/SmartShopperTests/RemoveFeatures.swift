//
//  RemoveFeatures.swift
//  SmartShopperTests
//
//  Created by Mac on 4/18/19.
//  Copyright © 2019 SmartShopperTeam. All rights reserved.
//

import Foundation
import XCTest

class RemoveFeatures: XCTestCase {
    
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
    
    // controls when a test item needs to be removed
    
    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    // removes item before each test if needed
    /* private func removeItem() throws -> Void {
     // checks if test items need to be removed
     if needsRemoveForItem1 {
     let remove1Result = Store.shared.removeItem(remove: "000000000000", in: AddItemFeatures.departmentList[0])
     if remove1Result != ReturnCode.itemRemoved {
     throw TestRemoveError.item1Failed
     }
     }
     if needsRemoveForItem2 {
     let remove2Result = Store.shared.removeItem(remove: "000000000000", in: AddItemFeatures.departmentList[7])
     if remove2Result != ReturnCode.itemRemoved {
     throw TestRemoveError.item2Failed
     }
     }
     }*/
    
    
    // Add item can yield four ReturnCodes, each test will access each one is returned by their corresponding circumstances
    
    
    func testItemRemoved() {
        let result: ReturnCode = Store.shared.removeItem(remove: "024100122332", in: RemoveFeatures.departmentList[0])

        // holds instance for cheez its
        let cheezItem: Item = Array<Item>(RemoveFeatures.store[RemoveFeatures.departmentList[0]]!.values)[0]

        let _ = Store.shared.addItem(nameOfItem: cheezItem.name, simplifiedSearchPhrase: cheezItem.categoryName, vendor: cheezItem.vendor, barcode: cheezItem.barcode, toThisDepartment: RemoveFeatures.departmentList[0], aisleOfItem: cheezItem.aisleNum)
        XCTAssertTrue(result == ReturnCode.itemRemoved)
    }
    
    func testItemBarcodeInvalid(){
        let itemBarcodeInvalid: ReturnCode = Store.shared.removeItem(remove: "543234", in: RemoveFeatures.departmentList[0])
        XCTAssert(itemBarcodeInvalid == ReturnCode.invalidBarcodelength, "error: \(itemBarcodeInvalid)")
    }
    
    func testItemNotInStore(){
        let itemNotFoundInStore: ReturnCode = Store.shared.removeItem(remove: "011132135973", in: RemoveFeatures.departmentList[0])
        XCTAssert(itemNotFoundInStore == ReturnCode.itemNotInStore, "error: \(itemNotFoundInStore)")
    }
}

