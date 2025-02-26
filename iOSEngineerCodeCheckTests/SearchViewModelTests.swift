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
        try await confirmation { repositriesFethced in
            viewModel.repositoriesPublisher
                .sink { repositories in
                    if repositories.isEmpty == false {
                        // Assert
                        repositriesFethced()
                    }
                }
                .store(in: &cancellables)

            // Act, Assert
            #expect(viewModel.repositories.isEmpty)
            #expect(viewModel.errorMessage == nil)
            await viewModel.searchRepositories(query: "foo")
            // Wait
            try await Task.sleep(for: .seconds(0.01))
        }
        // Assert
        #expect(viewModel.repositories.isEmpty == false)
        #expect(viewModel.errorMessage == nil)
    }

    @MainActor
    @Test
    mutating func fetchRepositoriesFailure() async throws {
        // Arrange
        let mockRepository = TestErrorGithubRepository(session: URLSession.shared)
        let viewModel = SearchViewModel(repository: mockRepository, translator: GithubRepositoryTranslator())
        try await confirmation { errorFetched in
            viewModel.errorMessagePublisher
                .sink { errorMessage in
                    if errorMessage != nil {
                        // Assert
                        errorFetched()
                    }
                }
                .store(in: &cancellables)

            // Act, Assert
            #expect(viewModel.repositories.isEmpty)
            #expect(viewModel.errorMessage == nil)
            await viewModel.searchRepositories(query: "foo")
            // Wait
            try await Task.sleep(for: .seconds(0.01))
        }
        // Assert
        #expect(viewModel.repositories.isEmpty)
        #expect(viewModel.errorMessage != nil)
    }
}
