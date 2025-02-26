//
//  TestSuccessGithubRepository.swift
//  iOSEngineerCodeCheckTests
//
//  Created by kento.yamazaki on 2025/02/26.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit
@testable
import iOSEngineerCodeCheck

// MARK: - TestSuccessGithubRepository

final class TestSuccessGithubRepository: GithubRepositoryProtocol {
    required init(session _: URLSession) {
        // セッションは使用しない
    }

    func searchRepositories(query _: String) async throws -> [GithubRepositoryEntity] {
        return [
            GithubRepositoryEntity(
                fullName: "Swift/Example",
                language: "Swift",
                stargazersCount: 100,
                watchersCount: 50,
                forksCount: 30,
                openIssuesCount: 10,
                owner: GithubOwnerEntity(avatarURL: "https://example.com/avatar.png")
            ),
            GithubRepositoryEntity(
                fullName: "",
                language: nil,
                stargazersCount: 0,
                watchersCount: 0,
                forksCount: 0,
                openIssuesCount: 0,
                owner: GithubOwnerEntity(avatarURL: "")
            ),
            GithubRepositoryEntity(
                fullName: "",
                language: "",
                stargazersCount: 0,
                watchersCount: 0,
                forksCount: 0,
                openIssuesCount: 0,
                owner: GithubOwnerEntity(avatarURL: "")
            ),
        ]
    }

    func fetchImage(from _: String) async throws -> UIImage {
        return UIImage()
    }
}
