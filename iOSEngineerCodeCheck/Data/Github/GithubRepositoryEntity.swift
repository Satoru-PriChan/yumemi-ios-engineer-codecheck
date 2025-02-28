//
//  GithubRepositoryEntity.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/02/26.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//
import Foundation

struct GithubRepositoryResponseEntity: Codable, Sendable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [GithubRepositoryEntity]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

struct GithubRepositoryEntity: Codable, Sendable {
    let id: Int
    let nodeId: String
    let name: String
    let fullName: String
    let owner: GithubOwnerEntity
    let isPrivate: Bool
    let htmlURL: String
    let description: String?
    let isFork: Bool
    let url: String
    let createdAt: String
    let updatedAt: String
    let pushedAt: String
    let homepage: String?
    let size: Int
    let stargazersCount: Int
    let watchersCount: Int
    let language: String?
    let forksCount: Int
    let openIssuesCount: Int
    let masterBranch: String?
    let defaultBranch: String
    let score: Int
    let archiveURL: String
    let assigneesURL: String
    let blobsURL: String
    let branchesURL: String
    let collaboratorsURL: String
    let commentsURL: String
    let commitsURL: String
    let compareURL: String
    let contentsURL: String
    let contributorsURL: String
    let deploymentsURL: String
    let downloadsURL: String
    let eventsURL: String
    let forksURL: String
    let gitCommitsURL: String
    let gitRefsURL: String
    let gitTagsURL: String
    let gitURL: String
    let issueCommentURL: String
    let issueEventsURL: String
    let issuesURL: String
    let keysURL: String
    let labelsURL: String
    let languagesURL: String
    let mergesURL: String
    let milestonesURL: String
    let notificationsURL: String
    let pullsURL: String
    let releasesURL: String
    let sshURL: String
    let stargazersURL: String
    let statusesURL: String
    let subscribersURL: String
    let subscriptionURL: String
    let tagsURL: String
    let teamsURL: String
    let treesURL: String
    let cloneURL: String
    let mirrorURL: String?
    let hooksURL: String
    let svnURL: String
    let forks: Int
    let openIssues: Int
    let watchers: Int
    let hasIssues: Bool
    let hasProjects: Bool
    let hasPages: Bool
    let hasWiki: Bool
    let hasDownloads: Bool
    let archived: Bool
    let disabled: Bool
    let visibility: String
    let license: GithubLicenseEntity?

    enum CodingKeys: String, CodingKey {
        case id
        case nodeId = "node_id"
        case name
        case fullName = "full_name"
        case owner
        case isPrivate = "private"
        case htmlURL = "html_url"
        case description
        case isFork = "fork"
        case url
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case homepage
        case size
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case masterBranch = "master_branch"
        case defaultBranch = "default_branch"
        case score
        case archiveURL = "archive_url"
        case assigneesURL = "assignees_url"
        case blobsURL = "blobs_url"
        case branchesURL = "branches_url"
        case collaboratorsURL = "collaborators_url"
        case commentsURL = "comments_url"
        case commitsURL = "commits_url"
        case compareURL = "compare_url"
        case contentsURL = "contents_url"
        case contributorsURL = "contributors_url"
        case deploymentsURL = "deployments_url"
        case downloadsURL = "downloads_url"
        case eventsURL = "events_url"
        case forksURL = "forks_url"
        case gitCommitsURL = "git_commits_url"
        case gitRefsURL = "git_refs_url"
        case gitTagsURL = "git_tags_url"
        case gitURL = "git_url"
        case issueCommentURL = "issue_comment_url"
        case issueEventsURL = "issue_events_url"
        case issuesURL = "issues_url"
        case keysURL = "keys_url"
        case labelsURL = "labels_url"
        case languagesURL = "languages_url"
        case mergesURL = "merges_url"
        case milestonesURL = "milestones_url"
        case notificationsURL = "notifications_url"
        case pullsURL = "pulls_url"
        case releasesURL = "releases_url"
        case sshURL = "ssh_url"
        case stargazersURL = "stargazers_url"
        case statusesURL = "statuses_url"
        case subscribersURL = "subscribers_url"
        case subscriptionURL = "subscription_url"
        case tagsURL = "tags_url"
        case teamsURL = "teams_url"
        case treesURL = "trees_url"
        case cloneURL = "clone_url"
        case mirrorURL = "mirror_url"
        case hooksURL = "hooks_url"
        case svnURL = "svn_url"
        case forks
        case openIssues = "open_issues"
        case watchers
        case hasIssues = "has_issues"
        case hasProjects = "has_projects"
        case hasPages = "has_pages"
        case hasWiki = "has_wiki"
        case hasDownloads = "has_downloads"
        case archived
        case disabled
        case visibility
        case license
    }

    init(
        id: Int,
        nodeId: String,
        name: String,
        fullName: String,
        owner: GithubOwnerEntity,
        isPrivate: Bool,
        htmlURL: String,
        description: String?,
        isFork: Bool,
        url: String,
        createdAt: String,
        updatedAt: String,
        pushedAt: String,
        homepage: String?,
        size: Int,
        stargazersCount: Int,
        watchersCount: Int,
        language: String?,
        forksCount: Int,
        openIssuesCount: Int,
        masterBranch: String?,
        defaultBranch: String,
        score: Int,
        archiveURL: String,
        assigneesURL: String,
        blobsURL: String,
        branchesURL: String,
        collaboratorsURL: String,
        commentsURL: String,
        commitsURL: String,
        compareURL: String,
        contentsURL: String,
        contributorsURL: String,
        deploymentsURL: String,
        downloadsURL: String,
        eventsURL: String,
        forksURL: String,
        gitCommitsURL: String,
        gitRefsURL: String,
        gitTagsURL: String,
        gitURL: String,
        issueCommentURL: String,
        issueEventsURL: String,
        issuesURL: String,
        keysURL: String,
        labelsURL: String,
        languagesURL: String,
        mergesURL: String,
        milestonesURL: String,
        notificationsURL: String,
        pullsURL: String,
        releasesURL: String,
        sshURL: String,
        stargazersURL: String,
        statusesURL: String,
        subscribersURL: String,
        subscriptionURL: String,
        tagsURL: String,
        teamsURL: String,
        treesURL: String,
        cloneURL: String,
        mirrorURL: String?,
        hooksURL: String,
        svnURL: String,
        forks: Int,
        openIssues: Int,
        watchers: Int,
        hasIssues: Bool,
        hasProjects: Bool,
        hasPages: Bool,
        hasWiki: Bool,
        hasDownloads: Bool,
        archived: Bool,
        disabled: Bool,
        visibility: String,
        license: GithubLicenseEntity?
    ) {
        self.id = id
        self.nodeId = nodeId
        self.name = name
        self.fullName = fullName
        self.owner = owner
        self.isPrivate = isPrivate
        self.htmlURL = htmlURL
        self.description = description
        self.isFork = isFork
        self.url = url
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.pushedAt = pushedAt
        self.homepage = homepage
        self.size = size
        self.stargazersCount = stargazersCount
        self.watchersCount = watchersCount
        self.language = language
        self.forksCount = forksCount
        self.openIssuesCount = openIssuesCount
        self.masterBranch = masterBranch
        self.defaultBranch = defaultBranch
        self.score = score
        self.archiveURL = archiveURL
        self.assigneesURL = assigneesURL
        self.blobsURL = blobsURL
        self.branchesURL = branchesURL
        self.collaboratorsURL = collaboratorsURL
        self.commentsURL = commentsURL
        self.commitsURL = commitsURL
        self.compareURL = compareURL
        self.contentsURL = contentsURL
        self.contributorsURL = contributorsURL
        self.deploymentsURL = deploymentsURL
        self.downloadsURL = downloadsURL
        self.eventsURL = eventsURL
        self.forksURL = forksURL
        self.gitCommitsURL = gitCommitsURL
        self.gitRefsURL = gitRefsURL
        self.gitTagsURL = gitTagsURL
        self.gitURL = gitURL
        self.issueCommentURL = issueCommentURL
        self.issueEventsURL = issueEventsURL
        self.issuesURL = issuesURL
        self.keysURL = keysURL
        self.labelsURL = labelsURL
        self.languagesURL = languagesURL
        self.mergesURL = mergesURL
        self.milestonesURL = milestonesURL
        self.notificationsURL = notificationsURL
        self.pullsURL = pullsURL
        self.releasesURL = releasesURL
        self.sshURL = sshURL
        self.stargazersURL = stargazersURL
        self.statusesURL = statusesURL
        self.subscribersURL = subscribersURL
        self.subscriptionURL = subscriptionURL
        self.tagsURL = tagsURL
        self.teamsURL = teamsURL
        self.treesURL = treesURL
        self.cloneURL = cloneURL
        self.mirrorURL = mirrorURL
        self.hooksURL = hooksURL
        self.svnURL = svnURL
        self.forks = forks
        self.openIssues = openIssues
        self.watchers = watchers
        self.hasIssues = hasIssues
        self.hasProjects = hasProjects
        self.hasPages = hasPages
        self.hasWiki = hasWiki
        self.hasDownloads = hasDownloads
        self.archived = archived
        self.disabled = disabled
        self.visibility = visibility
        self.license = license
    }
}

// オーナー情報を表す構造体
struct GithubOwnerEntity: Codable, Sendable {
    let login: String
    let id: Int
    let nodeId: String
    let avatarURL: String
    let gravatarId: String?
    let url: String
    let receivedEventsURL: String
    let type: String
    let htmlURL: String
    let followersURL: String
    let followingURL: String
    let gistsURL: String
    let starredURL: String
    let subscriptionsURL: String
    let organizationsURL: String
    let reposURL: String
    let eventsURL: String
    let siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case login
        case id
        case nodeId = "node_id"
        case avatarURL = "avatar_url"
        case gravatarId = "gravatar_id"
        case url
        case receivedEventsURL = "received_events_url"
        case type
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case siteAdmin = "site_admin"
    }

    init(
        login: String,
        id: Int,
        nodeId: String,
        avatarURL: String,
        gravatarId: String?,
        url: String,
        receivedEventsURL: String,
        type: String,
        htmlURL: String,
        followersURL: String,
        followingURL: String,
        gistsURL: String,
        starredURL: String,
        subscriptionsURL: String,
        organizationsURL: String,
        reposURL: String,
        eventsURL: String,
        siteAdmin: Bool
    ) {
        self.login = login
        self.id = id
        self.nodeId = nodeId
        self.avatarURL = avatarURL
        self.gravatarId = gravatarId
        self.url = url
        self.receivedEventsURL = receivedEventsURL
        self.type = type
        self.htmlURL = htmlURL
        self.followersURL = followersURL
        self.followingURL = followingURL
        self.gistsURL = gistsURL
        self.starredURL = starredURL
        self.subscriptionsURL = subscriptionsURL
        self.organizationsURL = organizationsURL
        self.reposURL = reposURL
        self.eventsURL = eventsURL
        self.siteAdmin = siteAdmin
    }
}

struct GithubLicenseEntity: Codable, Sendable {
    let key: String
    let name: String
    let url: String?
    let spdxId: String?
    let nodeId: String
    let htmlURL: String?

    enum CodingKeys: String, CodingKey {
        case key
        case name
        case url
        case spdxId = "spdx_id"
        case nodeId = "node_id"
        case htmlURL = "html_url"
    }

    init(
        key: String,
        name: String,
        url: String?,
        spdxId: String?,
        nodeId: String,
        htmlURL: String?
    ) {
        self.key = key
        self.name = name
        self.url = url
        self.spdxId = spdxId
        self.nodeId = nodeId
        self.htmlURL = htmlURL
    }
}
