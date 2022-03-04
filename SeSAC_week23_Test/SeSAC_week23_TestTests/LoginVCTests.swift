//
//  LoginVCTests.swift
//  SeSAC_week23_TestTests
//
//  Created by kokojong on 2022/03/02.
//

import XCTest
@testable import SeSAC_week23_Test

class LoginVCTests: XCTestCase {

    var sut: LoginViewController!

    override func setUpWithError() throws {
       // system under test
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        sut.loadViewIfNeeded()
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
       sut = nil
    }

    
    // BDD(Behavior Driven Development): Given, When, Then
    // TDD(Test Driven Development): Arrange, Act, Assert
//    func testLoginVC_ValidID_ReturnTrue() throws {
//        // Given, Arrange
//        sut.idTextField.text = "ko@koko.com"
//        // When, Act
//        let valid = sut.isValidID()
//        // Then, Assert
//        XCTAssertTrue(valid, "아이디에 @가 없거나 6자 미만!")
//        
//    }
//    
//    func testLoginVC_InvalidPW_ReturnFalse() throws {
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//        vc.loadViewIfNeeded()
//        
//        vc.pwTextField.text = "1234"
//        
//        let valid = vc.isValidPW()
//        
//        XCTAssertFalse(valid, "패스워드 로직")
//    }
//    
//    func testLoginVC_idTextField_ReturnNil() throws {
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//        vc.loadViewIfNeeded()
//        
//        vc.pwTextField = nil
//    
//        let value = vc.idTextField
//        
//        XCTAssertNil(value, "nilnil")
//    }
    

}
