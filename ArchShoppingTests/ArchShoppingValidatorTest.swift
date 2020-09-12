//
//  ArchShoppingTestValidator.swift
//  ArchShoppingTests
//
//  Created by Chetan Melkote nagaraj on 13/6/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import XCTest
@testable import ArchShopping

class ArchShoppingTestValidator: XCTestCase {
    
    let testValidator = validator()
    let testString = "test"
    
    let testValidEmail = "testing@testing.com"
    let testInvalidEmail = "testing@test"
    
    let testValidPassward = "Asdf1234!"
    let testInvalidPassword = "asdf1234!"
    
    let testValidMobile = "1234567899"
    let testInvalidMobile = "12345678999"
    
    let testEmailAvailable = "customer@email.com"
    
    func testStringIsEmpty(){
        XCTAssertEqual(testValidator.isTextNotEmpty(testString), true)
    }
    
    func testEmailIsValid() {
        XCTAssertEqual(testValidator.isEmailValid(testValidEmail), true)
        XCTAssertEqual(testValidator.isEmailValid(testInvalidEmail), false)
    }
    
    func testPasswordIsValid() {
        XCTAssertEqual(testValidator.isPasswordValid(testValidPassward), true)
        XCTAssertEqual(testValidator.isPasswordValid(testInvalidPassword), false)
    }
    
    func testMobileIsValid() {
        XCTAssertEqual(testValidator.isMobileNumber(testValidMobile), true)
        XCTAssertEqual(testValidator.isMobileNumber(testInvalidMobile), false)
    }
    
    func testEmailAvailble() {
        XCTAssertEqual(testValidator.isEmailAvailable(testEmailAvailable), true)
        //XCTAssertEqual(testValidator.isEmailAvailable(testEmailAvailable), false)
    }
    
    
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
