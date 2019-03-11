//
//  Store.swift
//  SmartShopper
//
//  Created by Nick Pierce on 3/10/19.
//  Copyright © 2019 SmartShopperTeam. All rights reserved.
//

import Foundation

// Model class retaining apposite data types and methods to extend necessary functionality for the UIViewControllers

// Enum to hold the cases for various actions by the user
fileprivate enum ReturnCode{
    case aisleOutOfRangeForDeparment
    case validAisle
    case goodToRemove
    case validItem
    case invalidBarcodelength
    case duplicateBarcode
    case duplicateItemForVendor
    case itemFromVendorIsUnique
    case itemAdded
    case itemNotInStore
    case itemAisleChanged
    case itemRemoved
}

// Struct to hold individual items
fileprivate struct Item: Equatable{
    
    // enumerates private attribute with their corresponding computed properties to control external behaviors
    
    // name of item
    private var _name: String
    fileprivate var name: String {  // read only
        return _name
    }
    
    // category name (used to facilitate searching for user: ex- don't type "2% lowfat skim milk" but just type "milk"
    private var _categoryName: String
    fileprivate var categoryName: String{ // read only
        return _categoryName
    }
    
    // vendor that supplies item
    private var _vendor: String
    fileprivate var vendor: String { //read only
        return _vendor
    }
    
    // unique barcode corresponding to item
    private var _barcode: String
    fileprivate var barcode: String { // read only
        return _barcode
    }
    
    // mutable value that denotes which asile the item can be found in
    private var _aisleNum: Int
    fileprivate var aisleNum: Int { // read and settable
        get{
            return _aisleNum
        }
        set(newAisle){
            _aisleNum = newAisle
        }
    }
    
    // private initializer for Item
    private init(name: String, categoryName: String, vendor: String, barcode: String, aisleNum: Int){
        
        self._name = name
        self._categoryName = categoryName
        self._vendor = vendor
        self._barcode = barcode
        self._aisleNum = aisleNum
        
    }
    
    // Recieves a potential barcode and forwards it to private method and return its result
    fileprivate static func validateEntry(toValidate barcode: String) -> ReturnCode {
        return validateBarcode(barcode) ? .validItem : .invalidBarcodelength
    }
    
    // Intakes a potential barcode number and validates length is suffice (12)
    private static func validateBarcode(_ possibleBarcode: String) -> Bool {
        // converts input to string and returns if length is equal to 12
        return possibleBarcode.count == 12
    }
    
    // renders, and returns, an Item
    fileprivate static func createItem(name: String, categoryName: String, vendor: String, barcode: String, aisleNum: Int!) -> Item {
        // invokes init and returns the object
        return Item.init(name: name, categoryName: categoryName, vendor: vendor, barcode: barcode, aisleNum: aisleNum != nil ? aisleNum : -1)
    }
    
    // denotes when two Items are equal
    static func ==( lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name && lhs.vendor == rhs.vendor  // albeit, barcode uniquely points to item, it is our interest to determine if two Items are unique if they differ in name or vendor
    }
}

// struct to refer to Departments of a store
struct Department: CustomStringConvertible, Equatable{
    
    // department Description
    internal var description: String {
        return String(format: "Department: %@ Aisles: %d-%d", self.name, self.minAisleNum, self.maxAisleNum)
    }
    
    // shared list of predefined Departments
    fileprivate static let departmentList : [Department] = [Department(name: "Grocery", minAisleNum: 10, maxAisleNum: 4)]
    
    // enumerates Department's attributes
    
    // name of Department
    private var _name: String
    fileprivate var name: String{ // read only
        return _name
    }
    
    // maximun ailseNum that a Department has; if has no aisle num then -1
    private var _maxAisleNum: Int
    fileprivate var maxAisleNum: Int { // read only
        return _maxAisleNum
    }
    
    // minimum ailseNum that a Department has; if has no aisle num then -1
    private var _minAisleNum: Int
    fileprivate var minAisleNum: Int {
        return _minAisleNum
    }
    
    // computed property to determine if Department hasAisles
    fileprivate var hasAisles: Bool {
        return self.maxAisleNum - self.minAisleNum > 0 // -1 - (-1) = 0 or doesn't retain ailses
    }
    
    // private initializer for Department
    private init(name: String, minAisleNum: Int, maxAisleNum: Int){
        self._name = name
        self._maxAisleNum = maxAisleNum
        self._minAisleNum = minAisleNum
    }
    
    // returns Department name
    internal static func returnDepartmentName(_ dept: Department) -> String {
        return dept.name
    }
    
    // validates that the aisleNum for a given department is valid/ in its range
    fileprivate static func validateEntry(isValid aisle: Int?, for dept: Department) -> ReturnCode {
        
        // some aisles are nil for that dept is guranteed to not retain any aisles
        if dept.hasAisles {
            // aisle will always occupy a value
            return inRange(aisle: aisle!, forDepartment: dept) ? .aisleOutOfRangeForDeparment : .validAisle
        }
        
        // department doesn't retain any aisles. Good to proceed then
        return .validAisle
    }
    
    //  determines if the ailseNum is in range for a given department
    private static func inRange(aisle: Int, forDepartment dept: Department) -> Bool {
        return aisle >= dept.minAisleNum && aisle <= dept.maxAisleNum
    }
    
    // from predefined list in Department return an Array<Department> containing only multivalue Departments
    internal static func returnMultivalueDepartments() -> [Department] {
        return departmentList.filter({$0.hasAisles})
    }
    
    // determines if two Departments are equal
    internal static func ==( lhs: Department, rhs: Department) -> Bool {
        return lhs.name == rhs.name
    }
}
