//
//  APIServiceTest.swift
//  SeSAC_week23_TestTests
//
//  Created by kokojong on 2022/03/03.
//

import XCTest
@testable import SeSAC_week23_Test

class APIServiceTest: XCTestCase {
    
    var sut: APIService!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        sut = APIService()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil

        try super.tearDownWithError()
        

    }

    // CallRequest -> number 1~45안에 있는지
    func testExample() throws {
        sut.number1 = 100
        print(sut.number1)
        sut.callRequest { value in
            print("callRequest",self.sut.number1) // -> 실행이 안된다(UnitTest는 동기로 되기 때문에 비동기 결과를 안기다림?)
            XCTAssertLessThan(self.sut.number1, 45)
            XCTAssertGreaterThanOrEqual(self.sut.number1, 1)
            
        }
        print(sut.number1)
    }

    // 비동기: expectation, fulfill, wait
    // 네트워크 환경: 아이폰 네트워크 응답x or 서버 점검, 지연 등
    // -> Mock, Dummy, Stub, Fake, Spy - 테스트가 가능한 객체를 만듬(임시로 교체? 갈아끼움)
    // -> 테스트 더블: 테스트 코드와 상호작용을 할 수 있는 가짜 객체로 교체(스턴트맨...?)
    // -> 속도 개선, 테스트 대상 격리, 예측이 불가능한 상황X
    func testExample2() throws {
        
        let promise = expectation(description: "waiting lotto number, completion invoked") // 진행할 내용 적음(test당 하나만 적기)
        
        
        
        self.sut.number1 = 30
        sut.callRequest { value in
            print("callRequest",self.sut.number1)
            XCTAssertLessThan(self.sut.number1, 45)
            XCTAssertGreaterThanOrEqual(self.sut.number1, 1)
            promise.fulfill() // 끝났음을 알려줌
            // expectation으로 정의한 테스트 조건을 충족한 시점에 호출
            
        }
        print(sut.number1)
        
        wait(for: [promise], timeout: 5) // timeout 최대 기다리는 시간 -> 이 시간이 넘어가면 fail로 처리
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
