//
//  GithubRepositoryTranslatorTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by kento.yamazaki on 2025/02/26.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import Testing
@testable
import iOSEngineerCodeCheck

struct GithubRepositoryTranslatorTests {
    var translator: GithubRepositoryTranslatorProtocol

    init() async throws {
        translator = GithubRepositoryTranslator()
    }

    @Test(
        "Single GithubRepositoryEntity Translation",
        arguments: [
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
    )
    func singleTranslation(_ entity: GithubRepositoryEntity) async throws {
        let model = translator.translate(from: entity)
        #expect(model.fullName == entity.fullName)
        if let language = entity.language {
            #expect(model.language == language)
        } else {
            #expect(model.language == "Unknown Language")
        }
        #expect(model.stargazersCount == entity.stargazersCount)
        #expect(model.watchersCount == entity.watchersCount)
        #expect(model.forksCount == entity.forksCount)
        #expect(model.openIssuesCount == entity.openIssuesCount)
        #expect(model.avatarURL == entity.owner.avatarURL)
    }

    @Test(
        "Multi GithubRepositoryEntity Translation",
        arguments: [
            [],
            [
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
            ],
        ]
    )
    func multiTranslation(_ entities: [GithubRepositoryEntity]) async throws {
        let models = translator.translate(from: entities)
        #expect(models.count == entities.count)
        for i in 0 ..< models.count {
            #expect(models[i].fullName == entities[i].fullName)
            if let language = entities[i].language {
                #expect(models[i].language == language)
            } else {
                #expect(models[i].language == "Unknown Language")
            }
            #expect(models[i].stargazersCount == entities[i].stargazersCount)
            #expect(models[i].watchersCount == entities[i].watchersCount)
            #expect(models[i].forksCount == entities[i].forksCount)
            #expect(models[i].openIssuesCount == entities[i].openIssuesCount)
            #expect(models[i].avatarURL == entities[i].owner.avatarURL)
        }
    }
}
