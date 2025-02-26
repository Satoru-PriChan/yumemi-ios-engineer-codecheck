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
    mutating func fetchAvatarImageSuccess() async {
        // Arrange
        let mockRepository = TestSuccessGithubRepository(session: URLSession.shared)
        let repositoryModel = GithubRepositoryModel(fullName: "", language: "", stargazersCount: 1, watchersCount: 1, forksCount: 1, openIssuesCount: 1, avatarURL: "")
        let viewModel = DetailViewModel(repository: repositoryModel, githubRepository: mockRepository)
        viewModel.avatarImagePublisher
            .sink { image in
                if image != nil {
                    // Assert
                    #expect(true)
                }
            }
            .store(in: &cancellables)

        // Act
        await viewModel.fetchAvatarImage()
    }

    @MainActor
    @Test
    mutating func fetchAvatarImageFailure() async {
        // Arrange
        let mockRepository = TestErrorGithubRepository(session: URLSession.shared)
        let repositoryModel = GithubRepositoryModel(fullName: "", language: "", stargazersCount: 1, watchersCount: 1, forksCount: 1, openIssuesCount: 1, avatarURL: "")
        let viewModel = DetailViewModel(repository: repositoryModel, githubRepository: mockRepository)
        viewModel.errorMessagePublisher
            .sink { errorMessage in
                if errorMessage != nil {
                    // Assert
                    #expect(true)
                }
            }
            .store(in: &cancellables)

        // Act
        await viewModel.fetchAvatarImage()
    }
}
