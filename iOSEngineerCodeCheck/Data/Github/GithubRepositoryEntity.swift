//
//  GithubRepositoryEntity.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/02/26.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import Foundation

struct GithubRepositoryResponseEntity: Codable, Sendable {
    let items: [GithubRepositoryEntity]
}

struct GithubRepositoryEntity: Codable, Sendable {
    let fullName: String
    let language: String?
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let owner: GithubOwnerEntity

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case language
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case owner
    }
}

struct GithubOwnerEntity: Codable, Sendable {
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
    }
}
