//
//  Store.swift
//  SmartShopper
//
//  Created by Nick Pierce on 3/10/19.
//  Copyright © 2019 SmartShopperTeam. All rights reserved.

//  TODO: append Store methods to invoke admin validation (login and create user)

import Foundation

// renders Notifications
internal extension Notification.Name{
    
    // enumerates static vars for post
    static var searchComplete: Notification.Name {
        return Notification.Name.init(rawValue: "search for user query done")
    }
}


// extension of String to append functionality to indicate whether a substring (regardless of case) is contained in another (regardless of case)
fileprivate extension String{
    
    func contains(substring: String) -> Bool{
        
        // error check to corroborate substring isn't empty
        if substring.count == 0{
            return false
        }
        
        // var to retain the current char to check
        var substringIndex: Int = 0
        
        // users can enter a capitalized or non-capitalized input.  Lowercase both strings to compare
        // a for loop to iterate over all the the characters
        for char in self.localizedLowercase{
            
            // checks for comparison, regardless of what substringIndex is
            if substring.localizedLowercase[substring.index(substring.startIndex, offsetBy: substringIndex)] == char {
                
                // increments substring and determines if that char is last comprised in substring
                substringIndex += 1
                if substringIndex == substring.count {  // last values has been check ex: "hello" -- (4+1) == 5
                    return true
                }
            }
            else {  // values don't match reset substringIndex
                substringIndex = 0
            }
        }
        
        // exited for loop without returning true.  No matches occur, return false
        return false
    }
}

// Model class retaining apposite data types and methods to extend necessary functionality for the UIViewControllers

// Enum to hold the cases for various actions by the user
internal enum ReturnCode{  // internal due to cases being accessed/evaluated by ViewControllers after invoking model methods
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
    case itemAisleNumChanged
    case itemRemoved
    case storeNumInvalid
    case storePasswordInvalid
    case adminAdded
    case adminAlreadyExist
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
    internal var aisleNum: Int { // read and settable
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
internal struct Department: CustomStringConvertible, Equatable, Hashable{
    
    // department Description
    internal var description: String {
        return String(format: "Department: %@ Aisles: %d-%d", self.name, self.minAisleNum, self.maxAisleNum)
    }
    
    // shared list of predefined Departments
    fileprivate static let departmentList : [Department] = [Department(name: "Grocery", minAisleNum: 4, maxAisleNum: 10), Department(name: "HBC", minAisleNum: 2, maxAisleNum: 4), Department(name: "Seasonal", minAisleNum: 1, maxAisleNum: 1), Department(name: "Meat", minAisleNum: -1, maxAisleNum: -1), Department(name: "Deli", minAisleNum: -1, maxAisleNum: -1), Department(name: "Bakery", minAisleNum: -1, maxAisleNum: -1), Department(name: "Produce", minAisleNum: -1, maxAisleNum: -1), Department(name: "Floral", minAisleNum: -1, maxAisleNum: -1), Department(name: "Frozen/Dairy", minAisleNum: -1, maxAisleNum: -1)]
    
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
    fileprivate static func returnDepartmentName(_ dept: Department) -> String {
        return dept.name
    }
    
    // validates that the aisleNum for a given department is valid/ in its range
    fileprivate static func validateEntry(isValid aisle: Int?, for dept: Department) -> ReturnCode {
        
        // some aisles are nil for that dept is guranteed to not retain any aisles
        if dept.hasAisles {
            // aisle will always occupy a value here
            return inRange(aisle: aisle!, forDepartment: dept) ? .aisleOutOfRangeForDeparment : .validAisle
        }
        
        // department doesn't retain any aisles. Good to proceed then
        return .validAisle
    }
    
    //  determines if the ailseNum is in range for a given department
    internal static func inRange(aisle: Int, forDepartment dept: Department) -> Bool {
        return aisle >= dept.minAisleNum && aisle <= dept.maxAisleNum
    }
    
    // from predefined list in Department return an Array<Department> containing only multivalue Departments
    fileprivate static func returnMultivalueDepartments() -> [Department] {
        return departmentList.filter({$0.hasAisles})
    }
    
    // determines if two Departments are equal
    internal static func ==( lhs: Department, rhs: Department) -> Bool {
        return lhs.name == rhs.name
    }
    
    // has automatic conformance to Hashable consequently of all type memebers being hashable.  Altering to where the Hasher of two Departments are the same if they are equal (hold same name)
    internal func hash(into hasher: inout Hasher){
        hasher.combine(self.name)  // feeds instance name (String) into Hasher to compute hashvalue & placement in dictionary
    }
}

// struct to retain state of Admin and their corresponding store
fileprivate struct Admin: Equatable, Hashable {
    
    // private Array containing all storePasswords
    private static let storePasswordAndNum: [Int : Int] = [404: 404, 123: 123, 987: 987] // initial data for demonstration
    // NOTE: storeNum is unique to store, so it is also an identifier for store
    
    // private static set holding the Admin
    private static var _adminLogin: Set<Admin>!
    private static var adminLogin: Set<Admin>{ // read only
        get {  // checks for nil
            return _adminLogin != nil ? _adminLogin : Set<Admin>()
        }
    }
    
    // enumerates attributes for admin
    
    // username
    private let _userName: String  // userName does not change
    fileprivate var userName: String {  // read only
        return _userName
    }
    
    // adminPassword
    private var _adminPassword: String
    fileprivate var adminPassword: String {  // read only
        return _adminPassword
    }
    
    // store number corresponding to admin
    private var _storeNumForAdmin: Int
    fileprivate var storeNumForAdmin: Int{ // read only
        return _storeNumForAdmin
    }
    
    // private initializer
    private init(userName: String, adminPassword: String, storeNumForAdmin: Int){
        self._userName = userName
        self._adminPassword = adminPassword
        self._storeNumForAdmin = storeNumForAdmin
    }
    
    // checks if storePassword is suffice, username is unique for store, and then appends admin to that store.  Error code otherwise
    fileprivate static func addAdmin(userName: String, withPassword password: String, forStore store: Int, validateWith storePassword: Int) -> ReturnCode {
        
        // checks if storePassword is correct/ points to a valid store and password to it is suffice
        if storePasswordAndNum[storePassword] != nil {  // store returned- check password
            if storePasswordAndNum[storePassword]! != store {
                return .storeNumInvalid
            }
        }
        else {  // no store returned on lookup
            return .storePasswordInvalid
        }
        
        // renders Admin object ( Note: not appending, but used to facilitate pending checks )
        let tempAdmin = Admin(userName: userName, adminPassword: password, storeNumForAdmin: store)
        
        // checks if admin is unique, add if so
        if adminLogin.contains(tempAdmin) { // admin already exist
            return .adminAlreadyExist
        }
        
        // appends
        _adminLogin.update(with: tempAdmin)
        return .adminAdded
    }
    
    // invoked to login an admin: validates adminPassword to userName and storePassword to storeNum
    fileprivate static func login( forAdmin username: String, withAdminPassword adminPassword: String, storePassword: Int) -> Bool {
        
        // corroborates the entered store password matches to some store
        if !(storePasswordAndNum[storePassword] != nil) { // does not match any password for any store
            return false
        }
        
        // validates that admin exist and is not unique (erroneous username, pw, or storeNum)
        if !Admin.adminLogin.contains(Admin.init(userName: username, adminPassword: adminPassword, storeNumForAdmin: Admin.storePasswordAndNum[storePassword]! )) {
            // admin not found
            return false
        }
        
        // password is tailored to a store AND that admin exist to that corresponding store
        return true
    }
    
    // determines equavlience for two admin
    fileprivate static func ==( lhs: Admin , rhs: Admin) -> Bool {
        return lhs.userName == rhs.userName || lhs.adminPassword == rhs.adminPassword 
    }
    
    // feeds integral components (that applied in equatable) into hash feeder
    fileprivate func hash(into hasher: inout Hasher){
        hasher.combine(self.userName)
        hasher.combine(self.adminPassword)
    }
}

// struct that coalesces the attributes and functionality of both classes, and is the external type, for ViewControllers to reference
internal struct Store{
    
    // shared static instance used by ViewControllers
    internal static var shared: Store = Store()
    
    // embedded hashmap containing all the departments, barcode (uniquely refers to Item), and Item
    private var store: [Department: [String: Item]] = [
        Department.departmentList[0]: ["024100122332": Item.createItem(name: "Cheez-Its", categoryName: "Crackers", vendor: "Sunshine", barcode: "024100122332", aisleNum: 5), "180855000032": Item.createItem(name: "Mild Black Bean & Corn Salsa", categoryName: "Salsa", vendor: "My Brother's Salsa", barcode: "180855000032", aisleNum: 6)],
        Department.departmentList[1] : ["011132135973": Item.createItem(name: "Alpo 13.2 Ounce T Bone Dog Food", categoryName: "Dog Food", vendor: "Purina", barcode: "011132135973", aisleNum: 3),"8718114326931": Item.createItem(name: "Alaska Deodorant Body Spray", categoryName: "Body Spray", vendor: "Axe", barcode: "8718114326931", aisleNum: 2)],
        Department.departmentList[2]: ["034613025631": Item.createItem(name: "Stars & Stripes Citro Candle", categoryName: "Candle", vendor: "Seasonal Trends", barcode: "034613025631", aisleNum: 1), "670171112330": Item.createItem(name: "White Cheddar", categoryName: "Popcorn", vendor: "Kernel Season's", barcode: "670171112330", aisleNum: 1)],
        Department.departmentList[3]: ["799418002507": Item.createItem(name: "Chicago's Finest Filet Mignon, Boneless", categoryName: "Steak", vendor: "Chicago Steak Company", barcode: "799418002507", aisleNum: nil), "077782008135": Item.createItem(name: "Italian Sausage", categoryName: "Sausage", vendor: "Johnsonville", barcode: "077782008135", aisleNum: nil)],
        Department.departmentList[4]: ["023700103093": Item.createItem(name: "Boneless Wings", categoryName: "Wings", vendor: "Deli Prepared", barcode: "023700103093", aisleNum: nil), "024508042263": Item.createItem(name: "Henri Hutin Valbrie 60% Cheese 7.00 oz", categoryName: "cheese", vendor: "Imported Deli Cheese", barcode: "024508042263", aisleNum: nil)],
        Department.departmentList[5]: ["028143014470": Item.createItem(name: "White And Dark Choclate Mousse Cake", categoryName: "Cake", vendor: "Lawlers Dessert", barcode: "028143014470", aisleNum: nil),"028143256115": Item.createItem(name: "Fluted Bourbon Pecan Pie", categoryName: "Pies", vendor: "Lawlers Dessert", barcode: "028143256115", aisleNum: nil)],
        Department.departmentList[6]: ["033383001531": Item.createItem(name: "Granny Smith 3lb Bag", categoryName: "Apples", vendor: "Bagged Apples", barcode: "033383001531", aisleNum: nil), "045255130300": Item.createItem(name: "Dried Banana Chips", categoryName: "Bananas", vendor: "Melissa's", barcode: "045255130300", aisleNum: nil)],
        Department.departmentList[7]: ["190033598152": Item.createItem(name: "Ceramic Flower Pot", categoryName: "Flower Pots", vendor: "Outgeek Bonsai", barcode: "190033598152", aisleNum: nil), "033849573510": Item.createItem(name: "28-in. Artificial Rose", categoryName: "Flowers", vendor: "Allstate Floral", barcode: "033849573510", aisleNum: nil)],
        Department.departmentList[8]: ["820103680561": Item.createItem(name: "Organic 2% Lowfat Choclate Milk", categoryName: "Milk", vendor: "Kirkland", barcode: "820103680561", aisleNum: nil), "077567254238": Item.createItem(name: "Natural Vanilla Ice Cream", categoryName: "Ice Cream", vendor: "Breyers", barcode: "077567254238", aisleNum: nil)]]
    // initial data integrated for demonstration
    
    // private initializer for Store
    private init(){}

    // viewController calls to validate passed information from user is valid to append to the Store's department-item data structure.  Append if it is, return error code else
    internal func addItem(nameOfItem itemName: String, simplifiedSearchPhrase categoryName: String, vendor: String, barcode: String, toThisDepartment dept: Department, aisleOfItem aisleNum: Int! = nil) -> ReturnCode {
        
        // renders Item (not done validating but encapsulating into an Item here facilitates tandem step
        let item: Item = Item.createItem(name: itemName, categoryName: categoryName, vendor: vendor, barcode: barcode, aisleNum: dept.name == "Seasonal" ? 1 : aisleNum)
        
        // verifies that the ailseNum is valid for Department (if aisleNum is nil then -1 will be assigned later, but is valid because the corresponding Department is always a non-aisle department
        
        if Department.validateEntry(isValid: aisleNum, for: dept) != .validAisle {
            return Department.validateEntry(isValid: aisleNum, for: dept)
        }
        // verifies that the barcode is palatable
        else if Item.validateEntry(toValidate: barcode) != .validItem {
            return Item.validateEntry(toValidate: barcode)
        }
        // verifies that item is unique to Department
        else if itemFromVendorIsUnique(for: item, in: dept) != .itemFromVendorIsUnique {
            return itemFromVendorIsUnique(for: item, in: dept)
        }
        else {
        // appends item to Department and returns that item has been appended
        Store.shared.store[dept]![item.barcode] = item
            return .itemAdded
        }
    }
    
    // indicates whether the Item is truly unique to the department (barcode and vendor-itemName pair is unique)
    private func itemFromVendorIsUnique(for item: Item, in dept: Department) -> ReturnCode {
        
        // checks if Department doesn't already contain that Item
        if Store.shared.store[dept]![item.barcode] != nil {  // Item found in department
            return .duplicateBarcode
        }
        
        // checks if itemName-vendor pair of the Department is unique
        for deptItem in Store.shared.store[dept]!.values {
            if item.name == deptItem.name && item.vendor == deptItem.vendor {
                return .duplicateItemForVendor
            }
        }
        
        // itemName-vendor pair and barcode is unique
        return .itemFromVendorIsUnique
    }
    
    // returns an array of all the multiAisle Departments
    private func returnMultiAisleDepartments() -> [Department] {
        return Department.returnMultivalueDepartments()
    }
    
    // returns an array of all the Departments
    internal func returnDepartments() -> [Department] {
        return Array<Department>(Store.shared.store.keys)
    }
    
    // returns Department name
    internal func returnDepartmentName(for dept: Department) -> String {
        return Department.returnDepartmentName(dept)
    }
    
    // specifies if Department is multivalue
    internal func departmentIsMultiAisle(for dept: Department) -> Bool {
        return self.returnMultiAisleDepartments().contains(dept)
    }
    
    // determines if the aisle num for the item (barcode) is valid and the item exist within Department. Amend ailse num if so, return errorCode otherwise
    internal func changeAisle(for barcode: String, in dept: Department, toThisAisle aisleNum: Int) -> ReturnCode {
        
        // verifies that aisleNum IS within aisle range of Department
        if Department.validateEntry(isValid: aisleNum, for: dept) != .validAisle {
            return Department.validateEntry(isValid: aisleNum, for: dept)
        }
        // verifies that barcode is suffice
        else if Item.validateEntry(toValidate: barcode) != .validItem {
            return Item.validateEntry(toValidate: barcode)
        }
        // verifies that barcode does exist within Department
        else if Store.shared.store[dept]![barcode] == nil { // barcode is unique
            return .itemNotInStore
        }
        else {
        // amends ailse num of item and returns that ailseNum is applied to item
        Store.shared.store[dept]![barcode]!.aisleNum = aisleNum
            return .itemAisleNumChanged
        }
    }
    
    // determines if the barcode of the suspected item exist and resides within the specified Department. Remove if it is, return errorCode otherwise
    internal func removeItem(remove barcode: String, in dept: Department) -> ReturnCode {
        
        // verifies that barcode is sufficient length
        if Item.validateEntry(toValidate: barcode) != .validItem {
            return Item.validateEntry(toValidate: barcode)
        }
        // verifies that barcode points to an item in specified Department
        else if Store.shared.store[dept]![barcode] == nil { // item is unique
            return .itemNotInStore
        }
        else {
        // removes item and returns that item has been removed
        Store.shared.store[dept]!.removeValue(forKey: barcode)
            return .itemRemoved
        }
    }

    // compiles are returns a list retaining to the locations of all the Item's queried.  If more than 3 locations are appended- or no results are garnered- then returns nil
    internal func search(findLocationOf searchName: String, in dept: Department) {
        
        // invokes thread to return query search
        DispatchQueue.global(qos: .userInitiated).async {
            
            // stores results of any matches (aisle location)
            var arrayResult: [Int] = []
            
            // call on custom contain for each item in the department and popullate array
            for item: Item in Store.shared.store[dept]!.values {
                
                // checks if search query is contained in categoryName || itemName
                if item.categoryName.contains(substring: searchName) || item.name.contains(substring: searchName) {
                    
                    // append item's ailse num if unique
                    if !arrayResult.contains(item.aisleNum) { // append
                        arrayResult.append(item.aisleNum)
                    }
                }
            }
            
            // evaluates how many items are comprised in query (if over 3 or nil return [])
            if arrayResult.count != 0 {
                
                if arrayResult.count <= 2 {  // less than two item locations -- good query
                    NotificationCenter.default.post(name: Notification.Name.searchComplete, object: Store.shared, userInfo: ["results" : arrayResult])
                    return
                }
                
            }
            
            // post notification with defualt value
            NotificationCenter.default.post(name: Notification.Name.searchComplete, object: Store.shared, userInfo: ["results" : []])
        }
    }

    // determines if an admin can login
    internal func login(username: String, adminPassword: String, storePassword: Int) -> Bool {
        
        // invokes Admin login function (forwards result)
        return Admin.login(forAdmin: username, withAdminPassword: adminPassword, storePassword: storePassword)
    }
    
    // assesses if admin can login, permits if so, and forwards commensurate return code
    internal func addAdmin(withUsername username: String, adminPassword: String, forStore store: Int, storePassword password: Int) -> ReturnCode{
        return Admin.addAdmin(userName: username, withPassword: adminPassword, forStore: store, validateWith: password)
    }
}
