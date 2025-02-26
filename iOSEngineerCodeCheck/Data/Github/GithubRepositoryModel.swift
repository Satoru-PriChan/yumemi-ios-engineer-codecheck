//
//  GithubRepositoryModel.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/02/26.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import Foundation

struct GithubRepositoryResponseModel: Codable, Sendable {
    let items: [GithubRepositoryModel]
}

struct GithubRepositoryModel: Codable, Sendable {
    let fullName: String
    let language: String?
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let owner: GithubOwnerModel

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

struct GithubOwnerModel: Codable, Sendable {
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
    }
}

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidImageData
}
