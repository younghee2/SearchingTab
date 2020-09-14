//
//  SearchingTabUITests.swift
//  SearchingTabUITests
//
//  Created by YOUNGHEE on 2020/09/08.
//  Copyright © 2020 kakaobank. All rights reserved.
//

import XCTest

class SearchingTabUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    //검색어를 입력하면 검색결과가 나오는지 확인 > 상세진입
    func test_SearchUserResultAvailable() {
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.exists)                                  // 검색창의 TextField가 있는지 확인
        searchField.tap()                                                 // 1. SearchBar의 TextField를 탭
        searchField.typeText("카카오뱅크\n")                                 // 2. 검색어 입력 후 키보드 내림
        let resultCellOfFirst = app.cells.firstMatch
        XCTAssertTrue(resultCellOfFirst.waitForExistence(timeout: 15.0)) // 3. 검색 결과가 있는지 확인 (최대 15초 동안 대기)
        resultCellOfFirst.tap()
    }

    override func tearDownWithError() throws {
    }


}
