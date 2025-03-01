//
//  SearchViewModelTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by kento.yamazaki on 2025/02/26.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import Combine
import Foundation
import Testing
@testable
import iOSEngineerCodeCheck
import UIKit

struct SearchViewModelTests {
    var cancellables: Set<AnyCancellable> = []

    @MainActor
    @Test
    mutating func fetchRepositoriesSuccess() async throws {
        // Arrange
        let mockRepository = TestSuccessGithubRepository(session: URLSession.shared)
        let viewModel = SearchViewModel(repository: mockRepository, translator: GithubRepositoryTranslator())
        // Assert
        #expect(viewModel.repositories.isEmpty)
        #expect(viewModel.isLoading == false)
        #expect(viewModel.totalCount == nil)
        // Act
        try await confirmation(expectedCount: 0) { errorCalled in
            viewModel.onError = { _ in
                errorCalled()
            }

            // Act, Assert
            await viewModel.searchRepositories(query: "foo", sort: "", order: "", perPage: 10)
            // Wait
            try await Task.sleep(for: .seconds(0.01))
            #expect(viewModel.repositories.isEmpty == false)
            #expect(viewModel.isLoading == false)
            #expect(viewModel.totalCount != nil)
        }
    }

    @MainActor
    @Test
    mutating func fetchRepositoriesFailure() async throws {
        // Arrange
        let mockRepository = TestErrorGithubRepository(session: URLSession.shared)
        let viewModel = SearchViewModel(repository: mockRepository, translator: GithubRepositoryTranslator())
        // Assert
        #expect(viewModel.repositories.isEmpty)
        #expect(viewModel.isLoading == false)
        #expect(viewModel.totalCount == nil)
        // Act
        try await confirmation(expectedCount: 1) { errorCalled in
            viewModel.onError = { _ in
                errorCalled()
            }

            // Act, Assert
            await viewModel.searchRepositories(query: "foo", sort: "", order: "", perPage: 10)
            // Wait
            try await Task.sleep(for: .seconds(0.01))
            #expect(viewModel.repositories.isEmpty)
            #expect(viewModel.isLoading == false)
            #expect(viewModel.totalCount == nil)
        }
    }
}
