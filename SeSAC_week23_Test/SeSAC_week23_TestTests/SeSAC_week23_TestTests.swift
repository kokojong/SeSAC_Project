//
//  SeSAC_week23_TestTests.swift
//  SeSAC_week23_TestTests
//
//  Created by kokojong on 2022/02/28.
//

import XCTest
@testable import SeSAC_week23_Test

class SeSAC_week23_TestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let array = [3,6,2,8]
        let sortedArray = array.sorted()
        
        XCTAssertEqual(sortedArray, [2,3,6,8])
        
    }
    
    func testTextFieldCount() throws {
//        let vc = ViewController()
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        vc.loadViewIfNeeded() // 이걸 먼저 해줘야 한다
        
        vc.firstTextField.text = "코코종"
        
        let count = vc.calculateTextFieldCount()

        XCTAssertEqual(count, 3)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
