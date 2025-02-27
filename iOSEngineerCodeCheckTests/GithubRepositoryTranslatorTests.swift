//
//  GithubRepositoryTranslatorTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by kento.yamazaki on 2025/02/26.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//
import Testing
@testable import iOSEngineerCodeCheck

struct GithubRepositoryTranslatorTests {
    var translator: GithubRepositoryTranslatorProtocol
    
    init() async throws {
        translator = GithubRepositoryTranslator()
    }
    
    @Test(
        "Single GithubRepositoryEntity Translation",
        arguments: [
            // 正常なデータ
            GithubRepositoryEntity(
                id: 1,
                nodeId: "node123",
                name: "ExampleRepo",
                fullName: "Swift/Example",
                owner: GithubOwnerEntity(
                    login: "user1",
                    id: 101,
                    nodeId: "ownerNode123",
                    avatarURL: "https://example.com/avatar.png",
                    gravatarId: nil,
                    url: "https://api.github.com/users/user1",
                    receivedEventsURL: "https://api.github.com/users/user1/received_events",
                    type: "User",
                    htmlURL: "https://github.com/user1",
                    followersURL: "https://api.github.com/users/user1/followers",
                    followingURL: "https://api.github.com/users/user1/following{/other_user}",
                    gistsURL: "https://api.github.com/users/user1/gists{/gist_id}",
                    starredURL: "https://api.github.com/users/user1/starred{/owner}{/repo}",
                    subscriptionsURL: "https://api.github.com/users/user1/subscriptions",
                    organizationsURL: "https://api.github.com/users/user1/orgs",
                    reposURL: "https://api.github.com/users/user1/repos",
                    eventsURL: "https://api.github.com/users/user1/events{/privacy}",
                    siteAdmin: false
                ),
                isPrivate: false,
                htmlURL: "https://github.com/Swift/Example",
                description: "An example repository",
                isFork: false,
                url: "https://api.github.com/repos/Swift/Example",
                createdAt: "2023-01-01T00:00:00Z",
                updatedAt: "2023-01-02T00:00:00Z",
                pushedAt: "2023-01-03T00:00:00Z",
                homepage: "https://example.com",
                size: 1024,
                stargazersCount: 100,
                watchersCount: 50,
                language: "Swift",
                forksCount: 30,
                openIssuesCount: 10,
                masterBranch: "main",
                defaultBranch: "main",
                score: 1,
                archiveURL: "https://api.github.com/repos/Swift/Example/{archive_format}{/ref}",
                assigneesURL: "https://api.github.com/repos/Swift/Example/assignees{/user}",
                blobsURL: "https://api.github.com/repos/Swift/Example/git/blobs{/sha}",
                branchesURL: "https://api.github.com/repos/Swift/Example/branches{/branch}",
                collaboratorsURL: "https://api.github.com/repos/Swift/Example/collaborators{/collaborator}",
                commentsURL: "https://api.github.com/repos/Swift/Example/comments{/number}",
                commitsURL: "https://api.github.com/repos/Swift/Example/commits{/sha}",
                compareURL: "https://api.github.com/repos/Swift/Example/compare/{base}...{head}",
                contentsURL: "https://api.github.com/repos/Swift/Example/contents/{+path}",
                contributorsURL: "https://api.github.com/repos/Swift/Example/contributors",
                deploymentsURL: "https://api.github.com/repos/Swift/Example/deployments",
                downloadsURL: "https://api.github.com/repos/Swift/Example/downloads",
                eventsURL: "https://api.github.com/repos/Swift/Example/events",
                forksURL: "https://api.github.com/repos/Swift/Example/forks",
                gitCommitsURL: "https://api.github.com/repos/Swift/Example/git/commits{/sha}",
                gitRefsURL: "https://api.github.com/repos/Swift/Example/git/refs{/sha}",
                gitTagsURL: "https://api.github.com/repos/Swift/Example/git/tags{/sha}",
                gitURL: "git://github.com/Swift/Example.git",
                issueCommentURL: "https://api.github.com/repos/Swift/Example/issues/comments{/number}",
                issueEventsURL: "https://api.github.com/repos/Swift/Example/issues/events{/number}",
                issuesURL: "https://api.github.com/repos/Swift/Example/issues{/number}",
                keysURL: "https://api.github.com/repos/Swift/Example/keys{/key_id}",
                labelsURL: "https://api.github.com/repos/Swift/Example/labels{/name}",
                languagesURL: "https://api.github.com/repos/Swift/Example/languages",
                mergesURL: "https://api.github.com/repos/Swift/Example/merges",
                milestonesURL: "https://api.github.com/repos/Swift/Example/milestones{/number}",
                notificationsURL: "https://api.github.com/repos/Swift/Example/notifications{?since,all,participating}",
                pullsURL: "https://api.github.com/repos/Swift/Example/pulls{/number}",
                releasesURL: "https://api.github.com/repos/Swift/Example/releases{/id}",
                sshURL: "git@github.com:Swift/Example.git",
                stargazersURL: "https://api.github.com/repos/Swift/Example/stargazers",
                statusesURL: "https://api.github.com/repos/Swift/Example/statuses/{sha}",
                subscribersURL: "https://api.github.com/repos/Swift/Example/subscribers",
                subscriptionURL: "https://api.github.com/repos/Swift/Example/subscription",
                tagsURL: "https://api.github.com/repos/Swift/Example/tags",
                teamsURL: "https://api.github.com/repos/Swift/Example/teams",
                treesURL: "https://api.github.com/repos/Swift/Example/git/trees{/sha}",
                cloneURL: "https://github.com/Swift/Example.git",
                mirrorURL: nil,
                hooksURL: "https://api.github.com/repos/Swift/Example/hooks",
                svnURL: "https://svn.github.com/Swift/Example",
                forks: 30,
                openIssues: 10,
                watchers: 50,
                hasIssues: true,
                hasProjects: true,
                hasPages: true,
                hasWiki: true,
                hasDownloads: true,
                archived: false,
                disabled: false,
                visibility: "public",
                license: GithubLicenseEntity(
                    key: "mit",
                    name: "MIT License",
                    url: "https://api.github.com/licenses/mit",
                    spdxId: "MIT",
                    nodeId: "MDc6TGljZW5zZW1pdA==",
                    htmlURL: "https://api.github.com/licenses/mit"
                )
            ),
            // 不完全なデータ
            GithubRepositoryEntity(
                id: 2,
                nodeId: "",
                name: "",
                fullName: "",
                owner: GithubOwnerEntity(
                    login: "",
                    id: 0,
                    nodeId: "",
                    avatarURL: "",
                    gravatarId: nil,
                    url: "",
                    receivedEventsURL: "",
                    type: "",
                    htmlURL: "",
                    followersURL: "",
                    followingURL: "",
                    gistsURL: "",
                    starredURL: "",
                    subscriptionsURL: "",
                    organizationsURL: "",
                    reposURL: "",
                    eventsURL: "",
                    siteAdmin: false
                ),
                isPrivate: false,
                htmlURL: "",
                description: nil,
                isFork: false,
                url: "",
                createdAt: "",
                updatedAt: "",
                pushedAt: "",
                homepage: nil,
                size: 0,
                stargazersCount: 0,
                watchersCount: 0,
                language: nil,
                forksCount: 0,
                openIssuesCount: 0,
                masterBranch: nil,
                defaultBranch: "",
                score: 0,
                archiveURL: "",
                assigneesURL: "",
                blobsURL: "",
                branchesURL: "",
                collaboratorsURL: "",
                commentsURL: "",
                commitsURL: "",
                compareURL: "",
                contentsURL: "",
                contributorsURL: "",
                deploymentsURL: "",
                downloadsURL: "",
                eventsURL: "",
                forksURL: "",
                gitCommitsURL: "",
                gitRefsURL: "",
                gitTagsURL: "",
                gitURL: "",
                issueCommentURL: "",
                issueEventsURL: "",
                issuesURL: "",
                keysURL: "",
                labelsURL: "",
                languagesURL: "",
                mergesURL: "",
                milestonesURL: "",
                notificationsURL: "",
                pullsURL: "",
                releasesURL: "",
                sshURL: "",
                stargazersURL: "",
                statusesURL: "",
                subscribersURL: "",
                subscriptionURL: "",
                tagsURL: "",
                teamsURL: "",
                treesURL: "",
                cloneURL: "",
                mirrorURL: nil,
                hooksURL: "",
                svnURL: "",
                forks: 0,
                openIssues: 0,
                watchers: 0,
                hasIssues: false,
                hasProjects: false,
                hasPages: false,
                hasWiki: false,
                hasDownloads: false,
                archived: false,
                disabled: false,
                visibility: "",
                license: nil
            )
        ]
    )
    func singleTranslation(_ entity: GithubRepositoryEntity) async throws {
        let model = translator.translate(from: entity)
        
        // 基本情報の検証
        #expect(model.repositoryID == entity.id)
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
        
        // オーナー情報の検証
        #expect(model.login == entity.owner.login)
        #expect(model.ownerId == entity.owner.id)
        #expect(model.ownerNodeId == entity.owner.nodeId)
        #expect(model.gravatarId == entity.owner.gravatarId)
        #expect(model.ownerUrl == entity.owner.url)
        #expect(model.receivedEventsURL == entity.owner.receivedEventsURL)
        #expect(model.type == entity.owner.type)
        #expect(model.ownerHtmlURL == entity.owner.htmlURL)
        #expect(model.followersURL == entity.owner.followersURL)
        #expect(model.followingURL == entity.owner.followingURL)
        #expect(model.gistsURL == entity.owner.gistsURL)
        #expect(model.starredURL == entity.owner.starredURL)
        #expect(model.subscriptionsURL == entity.owner.subscriptionsURL)
        #expect(model.organizationsURL == entity.owner.organizationsURL)
        #expect(model.reposURL == entity.owner.reposURL)
        #expect(model.ownerEventsURL == entity.owner.eventsURL)
        #expect(model.siteAdmin == entity.owner.siteAdmin)
        
        // ライセンス情報の検証
        if let license = entity.license {
            #expect(model.key == license.key)
            #expect(model.licenseName == license.name)
            #expect(model.licenseUrl == license.url ?? "N/A")
            #expect(model.spdxId == license.spdxId ?? "N/A")
            #expect(model.licenseNodeId == license.nodeId)
            #expect(model.licenseHtmlURL == license.htmlURL ?? "N/A")
        } else {
            #expect(model.key == "")
            #expect(model.licenseName == "No License")
            #expect(model.licenseUrl == nil)
            #expect(model.spdxId == nil)
            #expect(model.licenseNodeId == "")
            #expect(model.licenseHtmlURL == nil)
        }
    }
    
    @Test(
        "Multi GithubRepositoryEntity Translation",
        arguments: [
            GithubRepositoryResponseEntity(totalCount: 0, incompleteResults: false, items: []),
            GithubRepositoryResponseEntity(
                totalCount: 2,
                incompleteResults: true,
                items:
            [
                GithubRepositoryEntity(
                    id: 1,
                    nodeId: "node123",
                    name: "ExampleRepo",
                    fullName: "Swift/Example",
                    owner: GithubOwnerEntity(
                        login: "user1",
                        id: 101,
                        nodeId: "ownerNode123",
                        avatarURL: "https://example.com/avatar.png",
                        gravatarId: nil,
                        url: "https://api.github.com/users/user1",
                        receivedEventsURL: "https://api.github.com/users/user1/received_events",
                        type: "User",
                        htmlURL: "https://github.com/user1",
                        followersURL: "https://api.github.com/users/user1/followers",
                        followingURL: "https://api.github.com/users/user1/following{/other_user}",
                        gistsURL: "https://api.github.com/users/user1/gists{/gist_id}",
                        starredURL: "https://api.github.com/users/user1/starred{/owner}{/repo}",
                        subscriptionsURL: "https://api.github.com/users/user1/subscriptions",
                        organizationsURL: "https://api.github.com/users/user1/orgs",
                        reposURL: "https://api.github.com/users/user1/repos",
                        eventsURL: "https://api.github.com/users/user1/events{/privacy}",
                        siteAdmin: false
                    ),
                    isPrivate: false,
                    htmlURL: "https://github.com/Swift/Example",
                    description: "An example repository",
                    isFork: false,
                    url: "https://api.github.com/repos/Swift/Example",
                    createdAt: "2023-01-01T00:00:00Z",
                    updatedAt: "2023-01-02T00:00:00Z",
                    pushedAt: "2023-01-03T00:00:00Z",
                    homepage: "https://example.com",
                    size: 1024,
                    stargazersCount: 100,
                    watchersCount: 50,
                    language: "Swift",
                    forksCount: 30,
                    openIssuesCount: 10,
                    masterBranch: "main",
                    defaultBranch: "main",
                    score: 1,
                    archiveURL: "https://api.github.com/repos/Swift/Example/{archive_format}{/ref}",
                    assigneesURL: "https://api.github.com/repos/Swift/Example/assignees{/user}",
                    blobsURL: "https://api.github.com/repos/Swift/Example/git/blobs{/sha}",
                    branchesURL: "https://api.github.com/repos/Swift/Example/branches{/branch}",
                    collaboratorsURL: "https://api.github.com/repos/Swift/Example/collaborators{/collaborator}",
                    commentsURL: "https://api.github.com/repos/Swift/Example/comments{/number}",
                    commitsURL: "https://api.github.com/repos/Swift/Example/commits{/sha}",
                    compareURL: "https://api.github.com/repos/Swift/Example/compare/{base}...{head}",
                    contentsURL: "https://api.github.com/repos/Swift/Example/contents/{+path}",
                    contributorsURL: "https://api.github.com/repos/Swift/Example/contributors",
                    deploymentsURL: "https://api.github.com/repos/Swift/Example/deployments",
                    downloadsURL: "https://api.github.com/repos/Swift/Example/downloads",
                    eventsURL: "https://api.github.com/repos/Swift/Example/events",
                    forksURL: "https://api.github.com/repos/Swift/Example/forks",
                    gitCommitsURL: "https://api.github.com/repos/Swift/Example/git/commits{/sha}",
                    gitRefsURL: "https://api.github.com/repos/Swift/Example/git/refs{/sha}",
                    gitTagsURL: "https://api.github.com/repos/Swift/Example/git/tags{/sha}",
                    gitURL: "git://github.com/Swift/Example.git",
                    issueCommentURL: "https://api.github.com/repos/Swift/Example/issues/comments{/number}",
                    issueEventsURL: "https://api.github.com/repos/Swift/Example/issues/events{/number}",
                    issuesURL: "https://api.github.com/repos/Swift/Example/issues{/number}",
                    keysURL: "https://api.github.com/repos/Swift/Example/keys{/key_id}",
                    labelsURL: "https://api.github.com/repos/Swift/Example/labels{/name}",
                    languagesURL: "https://api.github.com/repos/Swift/Example/languages",
                    mergesURL: "https://api.github.com/repos/Swift/Example/merges",
                    milestonesURL: "https://api.github.com/repos/Swift/Example/milestones{/number}",
                    notificationsURL: "https://api.github.com/repos/Swift/Example/notifications{?since,all,participating}",
                    pullsURL: "https://api.github.com/repos/Swift/Example/pulls{/number}",
                    releasesURL: "https://api.github.com/repos/Swift/Example/releases{/id}",
                    sshURL: "git@github.com:Swift/Example.git",
                    stargazersURL: "https://api.github.com/repos/Swift/Example/stargazers",
                    statusesURL: "https://api.github.com/repos/Swift/Example/statuses/{sha}",
                    subscribersURL: "https://api.github.com/repos/Swift/Example/subscribers",
                    subscriptionURL: "https://api.github.com/repos/Swift/Example/subscription",
                    tagsURL: "https://api.github.com/repos/Swift/Example/tags",
                    teamsURL: "https://api.github.com/repos/Swift/Example/teams",
                    treesURL: "https://api.github.com/repos/Swift/Example/git/trees{/sha}",
                    cloneURL: "https://github.com/Swift/Example.git",
                    mirrorURL: nil,
                    hooksURL: "https://api.github.com/repos/Swift/Example/hooks",
                    svnURL: "https://svn.github.com/Swift/Example",
                    forks: 30,
                    openIssues: 10,
                    watchers: 50,
                    hasIssues: true,
                    hasProjects: true,
                    hasPages: true,
                    hasWiki: true,
                    hasDownloads: true,
                    archived: false,
                    disabled: false,
                    visibility: "public",
                    license: GithubLicenseEntity(
                        key: "mit",
                        name: "MIT License",
                        url: "https://api.github.com/licenses/mit",
                        spdxId: "MIT",
                        nodeId: "MDc6TGljZW5zZW1pdA==",
                        htmlURL: "https://api.github.com/licenses/mit"
                    )
                ),
                GithubRepositoryEntity(
                    id: 2,
                    nodeId: "",
                    name: "",
                    fullName: "",
                    owner: GithubOwnerEntity(
                        login: "",
                        id: 0,
                        nodeId: "",
                        avatarURL: "",
                        gravatarId: nil,
                        url: "",
                        receivedEventsURL: "",
                        type: "",
                        htmlURL: "",
                        followersURL: "",
                        followingURL: "",
                        gistsURL: "",
                        starredURL: "",
                        subscriptionsURL: "",
                        organizationsURL: "",
                        reposURL: "",
                        eventsURL: "",
                        siteAdmin: false
                    ),
                    isPrivate: false,
                    htmlURL: "",
                    description: nil,
                    isFork: false,
                    url: "",
                    createdAt: "",
                    updatedAt: "",
                    pushedAt: "",
                    homepage: nil,
                    size: 0,
                    stargazersCount: 0,
                    watchersCount: 0,
                    language: nil,
                    forksCount: 0,
                    openIssuesCount: 0,
                    masterBranch: nil,
                    defaultBranch: "",
                    score: 0,
                    archiveURL: "",
                    assigneesURL: "",
                    blobsURL: "",
                    branchesURL: "",
                    collaboratorsURL: "",
                    commentsURL: "",
                    commitsURL: "",
                    compareURL: "",
                    contentsURL: "",
                    contributorsURL: "",
                    deploymentsURL: "",
                    downloadsURL: "",
                    eventsURL: "",
                    forksURL: "",
                    gitCommitsURL: "",
                    gitRefsURL: "",
                    gitTagsURL: "",
                    gitURL: "",
                    issueCommentURL: "",
                    issueEventsURL: "",
                    issuesURL: "",
                    keysURL: "",
                    labelsURL: "",
                    languagesURL: "",
                    mergesURL: "",
                    milestonesURL: "",
                    notificationsURL: "",
                    pullsURL: "",
                    releasesURL: "",
                    sshURL: "",
                    stargazersURL: "",
                    statusesURL: "",
                    subscribersURL: "",
                    subscriptionURL: "",
                    tagsURL: "",
                    teamsURL: "",
                    treesURL: "",
                    cloneURL: "",
                    mirrorURL: nil,
                    hooksURL: "",
                    svnURL: "",
                    forks: 0,
                    openIssues: 0,
                    watchers: 0,
                    hasIssues: false,
                    hasProjects: false,
                    hasPages: false,
                    hasWiki: false,
                    hasDownloads: false,
                    archived: false,
                    disabled: false,
                    visibility: "",
                    license: nil
                )
            ])
        ]
    )
    func multiTranslation(_ responseEntity: GithubRepositoryResponseEntity) async throws {
        let responseModel = translator.translate(from: responseEntity)
        #expect(responseModel.items.count == responseEntity.items.count)
        #expect(responseModel.totalCount == responseEntity.totalCount)
        
        for i in 0 ..< responseModel.items.count {
            let model = responseModel.items[i]
            let entity = responseEntity.items[i]
            
            // 基本情報の検証
            #expect(model.repositoryID == entity.id)
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
            
            // オーナー情報の検証
            #expect(model.login == entity.owner.login)
            #expect(model.ownerId == entity.owner.id)
            #expect(model.ownerNodeId == entity.owner.nodeId)
            #expect(model.gravatarId == entity.owner.gravatarId)
            #expect(model.ownerUrl == entity.owner.url)
            #expect(model.receivedEventsURL == entity.owner.receivedEventsURL)
            #expect(model.type == entity.owner.type)
            #expect(model.ownerHtmlURL == entity.owner.htmlURL)
            #expect(model.followersURL == entity.owner.followersURL)
            #expect(model.followingURL == entity.owner.followingURL)
            #expect(model.gistsURL == entity.owner.gistsURL)
            #expect(model.starredURL == entity.owner.starredURL)
            #expect(model.subscriptionsURL == entity.owner.subscriptionsURL)
            #expect(model.organizationsURL == entity.owner.organizationsURL)
            #expect(model.reposURL == entity.owner.reposURL)
            #expect(model.ownerEventsURL == entity.owner.eventsURL)
            #expect(model.siteAdmin == entity.owner.siteAdmin)
            
            // ライセンス情報の検証
            if let license = entity.license {
                #expect(model.key == license.key)
                #expect(model.licenseName == license.name)
                #expect(model.licenseUrl == license.url ?? "N/A")
                #expect(model.spdxId == license.spdxId ?? "N/A")
                #expect(model.licenseNodeId == license.nodeId)
                #expect(model.licenseHtmlURL == license.htmlURL ?? "N/A")
            } else {
                #expect(model.key == "")
                #expect(model.licenseName == "No License")
                #expect(model.licenseUrl == nil)
                #expect(model.spdxId == nil)
                #expect(model.licenseNodeId == "")
                #expect(model.licenseHtmlURL == nil)
            }
        }
    }
}
