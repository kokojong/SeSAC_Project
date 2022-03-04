//
//  ValidationTests.swift
//  SeSAC_week23_TestTests
//
//  Created by kokojong on 2022/03/02.
//

import XCTest
@testable import SeSAC_week23_Test

class ValidationTests: XCTestCase {

    var sut: Validator!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        sut = Validator()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testValidator_validID_ReturnTrue() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // Given
        let user = User(id: "koko@ko.com", password: "123456", check: "123456")
        
        
        // When
        let valid = sut.isValidID(id: user.id)
        
        // Then
        XCTAssertTrue(valid, "ididid")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
