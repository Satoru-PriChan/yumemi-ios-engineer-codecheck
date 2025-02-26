//
//  GithubRepositoryTranslator.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/02/26.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol GithubRepositoryTranslatorProtocol {
    func translate(from entity: GithubRepositoryEntity) -> GithubRepositoryModel
    func translate(from entities: [GithubRepositoryEntity]) -> [GithubRepositoryModel]
}

final class GithubRepositoryTranslator: GithubRepositoryTranslatorProtocol {
    func translate(from entity: GithubRepositoryEntity) -> GithubRepositoryModel {
        return GithubRepositoryModel(
            fullName: entity.fullName,
            language: entity.language ?? "Unknown Language",
            stargazersCount: entity.stargazersCount,
            watchersCount: entity.watchersCount,
            forksCount: entity.forksCount,
            openIssuesCount: entity.openIssuesCount,
            avatarURL: entity.owner.avatarURL
        )
    }

    func translate(from entities: [GithubRepositoryEntity]) -> [GithubRepositoryModel] {
        return entities.map { translate(from: $0) }
    }
}
