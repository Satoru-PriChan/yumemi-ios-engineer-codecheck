//
//  iOSEngineerCodeCheckUITests.swift
//  iOSEngineerCodeCheckUITests
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//
import XCTest

@MainActor
class iOSEngineerCodeCheckUITests: XCTestCase, Sendable {
    var app: XCUIApplication = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testSearchAndDetailViewFlow() {
        // MARK: - 1. SearchViewController で検索を実行
        app.launch()
        // 画面が表示されるまで待機
        let searchField = app.otherElements["Search"]
        waitToAppear(for: searchField)
        XCTAssertTrue(searchField.exists, "Search bar should exist")
        
        searchField.tap()
        searchField.typeText("Swift\n") // "Swift" を検索
        
        // 検索結果が表示されるまで待機
        let firstCell = waitToHittable(for: app.tables.cells.element(boundBy: 0))
        XCTAssertTrue(firstCell.exists, "Search results should be displayed")
        
        // MARK: - 2. 検索結果の一つをタップして DetailViewController に遷移
        firstCell.tap()
        
        
        let titleLabel = app.staticTexts["TitleLabel"]
        let languageLabel = app.staticTexts["LanguageLabel"]
        let starsLabel = app.staticTexts["StarsLabel"]
        let watchersLabel = app.staticTexts["WatchersLabel"]
        let forksLabel = app.staticTexts["ForksLabel"]
        let openIssuesLabel = app.staticTexts["OpenIssuesLabel"]
        // 詳細画面が表示されるまで待機
        waitToAppear(for: titleLabel)
        XCTAssertTrue(titleLabel.exists, "Detail view title should be displayed")
        XCTAssertTrue(languageLabel.exists, "Detail view language should be displayed")
        XCTAssertTrue(starsLabel.exists, "Detail view stars should be displayed")
        XCTAssertTrue(watchersLabel.exists, "Detail view watchers should be displayed")
        XCTAssertTrue(forksLabel.exists, "Detail forks language should be displayed")
        XCTAssertTrue(openIssuesLabel.exists, "Detail open issues should be displayed")
        
        // MARK: - 3. 戻るボタンを押して SearchViewController に戻る
        let backButton = app.navigationBars.buttons.element(boundBy: 0)
        XCTAssertTrue(backButton.exists, "Back button should exist")
        backButton.tap()
        
        // MARK: - 4. 検索結果が保持されていることを確認
        // 検索画面が表示されるまで待機
        waitToAppear(for: firstCell)
        XCTAssertTrue(firstCell.exists, "Search results should still be displayed after returning")
    }
}
