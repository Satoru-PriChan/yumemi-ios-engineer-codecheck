import Foundation

struct GithubRepositoryResponseModel: Identifiable, Sendable, Hashable {
    let id = UUID()
    let totalCount: Int
    let incompleteResults: Bool
    let items: [GithubRepositoryModel]
}

struct GithubRepositoryModel: Identifiable, Sendable, Hashable {
    // MARK: - Repository

    let id = UUID()
    let repositoryID: Int
    let fullName: String
    let language: String
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let avatarURL: String
    let nodeId: String
    let name: String
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

    // MARK: - Owner

    let login: String
    let ownerId: Int
    let ownerNodeId: String
    let gravatarId: String?
    let ownerUrl: String
    let receivedEventsURL: String
    let type: String
    let ownerHtmlURL: String
    let followersURL: String
    let followingURL: String
    let gistsURL: String
    let starredURL: String
    let subscriptionsURL: String
    let organizationsURL: String
    let reposURL: String
    let ownerEventsURL: String
    let siteAdmin: Bool

    // MARK: - License

    let key: String
    let licenseName: String
    let licenseUrl: String?
    let spdxId: String?
    let licenseNodeId: String
    let licenseHtmlURL: String?

    // MARK: - Computed Properties for URL Conversion

    var htmlURLAsURL: URL? { URL(string: htmlURL) }
    var urlAsURL: URL? { URL(string: url) }
    var avatarURLAsURL: URL? { URL(string: avatarURL) }
    var archiveURLAsURL: URL? { URL(string: archiveURL) }
    var assigneesURLAsURL: URL? { URL(string: assigneesURL) }
    var blobsURLAsURL: URL? { URL(string: blobsURL) }
    var branchesURLAsURL: URL? { URL(string: branchesURL) }
    var collaboratorsURLAsURL: URL? { URL(string: collaboratorsURL) }
    var commentsURLAsURL: URL? { URL(string: commentsURL) }
    var commitsURLAsURL: URL? { URL(string: commitsURL) }
    var compareURLAsURL: URL? { URL(string: compareURL) }
    var contentsURLAsURL: URL? { URL(string: contentsURL) }
    var contributorsURLAsURL: URL? { URL(string: contributorsURL) }
    var deploymentsURLAsURL: URL? { URL(string: deploymentsURL) }
    var downloadsURLAsURL: URL? { URL(string: downloadsURL) }
    var eventsURLAsURL: URL? { URL(string: eventsURL) }
    var forksURLAsURL: URL? { URL(string: forksURL) }
    var gitCommitsURLAsURL: URL? { URL(string: gitCommitsURL) }
    var gitRefsURLAsURL: URL? { URL(string: gitRefsURL) }
    var gitTagsURLAsURL: URL? { URL(string: gitTagsURL) }
    var gitURLAsURL: URL? { URL(string: gitURL) }
    var issueCommentURLAsURL: URL? { URL(string: issueCommentURL) }
    var issueEventsURLAsURL: URL? { URL(string: issueEventsURL) }
    var issuesURLAsURL: URL? { URL(string: issuesURL) }
    var keysURLAsURL: URL? { URL(string: keysURL) }
    var labelsURLAsURL: URL? { URL(string: labelsURL) }
    var languagesURLAsURL: URL? { URL(string: languagesURL) }
    var mergesURLAsURL: URL? { URL(string: mergesURL) }
    var milestonesURLAsURL: URL? { URL(string: milestonesURL) }
    var notificationsURLAsURL: URL? { URL(string: notificationsURL) }
    var pullsURLAsURL: URL? { URL(string: pullsURL) }
    var releasesURLAsURL: URL? { URL(string: releasesURL) }
    var sshURLAsURL: URL? { URL(string: sshURL) }
    var stargazersURLAsURL: URL? { URL(string: stargazersURL) }
    var statusesURLAsURL: URL? { URL(string: statusesURL) }
    var subscribersURLAsURL: URL? { URL(string: subscribersURL) }
    var subscriptionURLAsURL: URL? { URL(string: subscriptionURL) }
    var tagsURLAsURL: URL? { URL(string: tagsURL) }
    var teamsURLAsURL: URL? { URL(string: teamsURL) }
    var treesURLAsURL: URL? { URL(string: treesURL) }
    var cloneURLAsURL: URL? { URL(string: cloneURL) }
    var mirrorURLAsURL: URL? { mirrorURL.flatMap { URL(string: $0) } }
    var hooksURLAsURL: URL? { URL(string: hooksURL) }
    var svnURLAsURL: URL? { URL(string: svnURL) }
    var ownerUrlAsURL: URL? { URL(string: ownerUrl) }
    var receivedEventsURLAsURL: URL? { URL(string: receivedEventsURL) }
    var ownerHtmlURLAsURL: URL? { URL(string: ownerHtmlURL) }
    var followersURLAsURL: URL? { URL(string: followersURL) }
    var followingURLAsURL: URL? { URL(string: followingURL) }
    var gistsURLAsURL: URL? { URL(string: gistsURL) }
    var starredURLAsURL: URL? { URL(string: starredURL) }
    var subscriptionsURLAsURL: URL? { URL(string: subscriptionsURL) }
    var organizationsURLAsURL: URL? { URL(string: organizationsURL) }
    var reposURLAsURL: URL? { URL(string: reposURL) }
    var ownerEventsURLAsURL: URL? { URL(string: ownerEventsURL) }
    var licenseUrlAsURL: URL? { licenseUrl.flatMap { URL(string: $0) } }
    var licenseHtmlURLAsURL: URL? { licenseHtmlURL.flatMap { URL(string: $0) } }

    // MARK: - Others

    // String? 型の language を Language? 型に変換
    var languageType: SearchLanguage? {
        return SearchLanguage(rawValue: language)
    }
}
