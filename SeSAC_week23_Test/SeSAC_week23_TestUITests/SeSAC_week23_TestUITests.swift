//
//  SeSAC_week23_TestUITests.swift
//  SeSAC_week23_TestUITests
//
//  Created by kokojong on 2022/02/28.
//

import XCTest

class SeSAC_week23_TestUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false // 디폴트가 true여서 이걸 false로? 처음에 해줌

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
                
        app.staticTexts["First"].tap()
        app.staticTexts["second"].tap()
        app.staticTexts["third"].tap()
                        
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func textVCTransition() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.staticTexts["second"].tap()
        app.staticTexts["third"].tap()
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
