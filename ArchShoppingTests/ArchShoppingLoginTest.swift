//
//  ArchShoppingLoginTest.swift
//  ArchShoppingTests
//
//  Created by Chetan Melkote nagaraj on 14/6/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import XCTest
@testable import ArchShopping

class ArchShoppingLoginTest: XCTestCase {
    
    let email = "john@mail.com"
    let password = "Asdf1234!"
    var cid = 1
    
    let testLogin = loginModel()
    
    func testAuthenticateCustomer() {
        cid = testLogin.authenticateCustomer(username: email, password: password)
        XCTAssertEqual(cid, 1)
    }
    
    func testGetCustomerDetails() {
        let firstName = testLogin.getCustomerDetails(cid: cid)
        XCTAssertEqual(firstName, "John")
    }
    
    


}
