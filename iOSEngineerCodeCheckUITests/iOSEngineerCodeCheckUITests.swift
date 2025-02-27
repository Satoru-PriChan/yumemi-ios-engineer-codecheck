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
    var app: XCUIApplication = .init()

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {}

    func testSearchAndDetailViewFlow() {
        XCTContext.runActivity(named: "SearchView 検索実行") { _ in
            app.launch()
            let searchField = app.textFields["SearchView_SearchBar"]
            waitToAppear(for: searchField)
            XCTAssertTrue(searchField.exists, "Search bar should exist")
            searchField.tap()
            tapElementAndWaitForKeyboardToAppear(element: searchField)
            searchField.typeText("Swift\n") // "Swift" を検索
        }

        XCTContext.runActivity(named: "SearchView 検索結果タップ") { _ in
            // 検索結果が表示されるまで待機
            let firstCell = waitToHittable(for: app.cells.element(boundBy: 0))
            XCTAssertTrue(firstCell.exists, "Search results should be displayed")
            firstCell.tap()
        }

        XCTContext.runActivity(named: "DetailView 詳細画面UI要素があるか") { _ in
            let titleLabel = app.staticTexts["DetailView_TitleLabel"]
            let languageLabel = app.staticTexts["DetailView_LanguageLabel"]
            let starsLabel = app.staticTexts["DetailView_StarsLabel"]
            let watchersLabel = app.staticTexts["DetailView_WatchersLabel"]
            let forksLabel = app.staticTexts["DetailView_ForksLabel"]
            let openIssuesLabel = app.staticTexts["DetailView_OpenIssuesLabel"]
            // 詳細画面が表示されるまで待機
            waitToAppear(for: titleLabel)
            XCTAssertTrue(titleLabel.exists, "Detail view title should be displayed")
            XCTAssertTrue(languageLabel.exists, "Detail view language should be displayed")
            XCTAssertTrue(starsLabel.exists, "Detail view stars should be displayed")
            XCTAssertTrue(watchersLabel.exists, "Detail view watchers should be displayed")
            XCTAssertTrue(forksLabel.exists, "Detail forks language should be displayed")
            XCTAssertTrue(openIssuesLabel.exists, "Detail open issues should be displayed")
        }

        XCTContext.runActivity(named: "DetailView 戻るボタンを押して SearchView に戻る") { _ in
            let backButton = app.navigationBars.buttons.element(boundBy: 0)
            XCTAssertTrue(backButton.exists, "Back button should exist")
            backButton.tap()
        }

        XCTContext.runActivity(named: "DetailView 検索結果が保持されていることを確認") { _ in
            // 検索画面が表示されるまで待機
            let firstCell = app.cells.element(boundBy: 0)
            waitToAppear(for: firstCell)
            XCTAssertTrue(firstCell.exists, "Search results should still be displayed after returning")
        }
    }
}
