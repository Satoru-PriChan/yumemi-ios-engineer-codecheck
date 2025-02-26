//
//  DetailViewModelTests.swift
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

struct DetailViewModelTests {
    var cancellables: Set<AnyCancellable> = []

    @MainActor
    @Test
    mutating func fetchAvatarImageSuccess() async throws {
        // Arrange
        let mockRepository = TestSuccessGithubRepository(session: URLSession.shared)
        let repositoryModel = GithubRepositoryModel(fullName: "", language: "", stargazersCount: 1, watchersCount: 1, forksCount: 1, openIssuesCount: 1, avatarURL: "")
        let viewModel = DetailViewModel(repository: repositoryModel, githubRepository: mockRepository)
        try await confirmation { imageFetched in
            viewModel.avatarImagePublisher
                .sink { image in
                    if image != nil {
                        // Assert
                        imageFetched()
                    }
                }
                .store(in: &cancellables)

            // Act
            await viewModel.fetchAvatarImage()
            // Need to wait because confirmation does not wait https://forums.swift.org/t/testing-closure-based-asynchronous-apis/73705/34
            try await Task.sleep(for: .seconds(0.01))
        }
    }

    @MainActor
    @Test
    mutating func fetchAvatarImageFailure() async throws {
        // Arrange
        let mockRepository = TestErrorGithubRepository(session: URLSession.shared)
        let repositoryModel = GithubRepositoryModel(fullName: "", language: "", stargazersCount: 1, watchersCount: 1, forksCount: 1, openIssuesCount: 1, avatarURL: "")
        let viewModel = DetailViewModel(repository: repositoryModel, githubRepository: mockRepository)
        try await confirmation { errorFetched in
            viewModel.errorMessagePublisher
                .sink { errorMessage in
                    if errorMessage != nil {
                        // Assert
                        errorFetched()
                    }
                }
                .store(in: &cancellables)

            // Act
            await viewModel.fetchAvatarImage()
            // wait
            try await Task.sleep(for: .seconds(0.01))
        }
    }
}
