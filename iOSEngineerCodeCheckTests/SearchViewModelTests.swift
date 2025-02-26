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
    mutating func fetchRepositoriesSuccess() async {
        // Arrange
        let mockRepository = TestSuccessGithubRepository(session: URLSession.shared)
        let viewModel = SearchViewModel(repository: mockRepository, translator: GithubRepositoryTranslator())
        viewModel.repositoriesPublisher
            .sink { [weak viewModel] repositories in
                if repositories.isEmpty == false {
                    // Assert
                    #expect(true)
                    #expect((viewModel?.repositories.isEmpty ?? false) == false)
                    #expect(viewModel?.errorMessage == nil)
                }
            }
            .store(in: &cancellables)

        // Act, Assert
        #expect(viewModel.repositories.isEmpty)
        #expect(viewModel.errorMessage == nil)
        await viewModel.searchRepositories(query: "foo")
    }

    @MainActor
    @Test
    mutating func fetchRepositoriesFailure() async {
        // Arrange
        let mockRepository = TestErrorGithubRepository(session: URLSession.shared)
        let viewModel = SearchViewModel(repository: mockRepository, translator: GithubRepositoryTranslator())
        viewModel.errorMessagePublisher
            .sink { [weak viewModel] errorMessage in
                if errorMessage != nil {
                    // Assert
                    #expect(true)
                    #expect(viewModel?.repositories.isEmpty ?? false)
                    #expect(viewModel?.errorMessage != nil)
                }
            }
            .store(in: &cancellables)

        // Act, Assert
        #expect(viewModel.repositories.isEmpty)
        #expect(viewModel.errorMessage == nil)
        await viewModel.searchRepositories(query: "foo")
    }
}
