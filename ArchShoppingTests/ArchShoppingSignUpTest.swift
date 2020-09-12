//
//  ArchShoppingSignUp.swift
//  ArchShoppingTests
//
//  Created by Chetan Melkote nagaraj on 13/6/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import XCTest
@testable import ArchShopping

class ArchShoppingSignUp: XCTestCase {

    let fName = "John"
    let lName = "Smith"
    let email = "john@mail.com"
    let password = "Asdf1234!"
    let mobile = "1234567899"
    let dob = "06/11/2017"
    var count = 0
    
    let testSignUp = signUpModel()
    
    func testGetRecordCount() {
        count = testSignUp.getRecordsCount()
    }
    
    func testUpdateCustomerDetials() {
        testSignUp.updateCustomerDetails(count: count, firstName: fName, lastName: lName, eMail: email, mobile: mobile, dob: dob)
    }
    
    func testUpdateCustomerMaster() {
        testSignUp.updateCustomerMaster(count: count, email: email, password: password)
    }
    
    
}
