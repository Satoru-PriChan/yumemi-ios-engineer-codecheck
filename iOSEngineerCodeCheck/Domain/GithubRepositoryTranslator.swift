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
    func translate(from entity: GithubRepositoryResponseEntity) -> GithubRepositoryResponseModel
}

final class GithubRepositoryTranslator: GithubRepositoryTranslatorProtocol {
    func translate(from entity: GithubRepositoryEntity) -> GithubRepositoryModel {
        return GithubRepositoryModel(
            repositoryID: entity.id,
            fullName: entity.fullName,
            language: entity.language ?? "Unknown Language",
            stargazersCount: entity.stargazersCount,
            watchersCount: entity.watchersCount,
            forksCount: entity.forksCount,
            openIssuesCount: entity.openIssuesCount,
            avatarURL: entity.owner.avatarURL,
            nodeId: entity.nodeId,
            name: entity.name,
            isPrivate: entity.isPrivate,
            htmlURL: entity.htmlURL,
            description: entity.description,
            isFork: entity.isFork,
            url: entity.url,
            createdAt: entity.createdAt,
            updatedAt: entity.updatedAt,
            pushedAt: entity.pushedAt,
            homepage: entity.homepage,
            size: entity.size,
            masterBranch: entity.masterBranch,
            defaultBranch: entity.defaultBranch,
            score: entity.score,
            archiveURL: entity.archiveURL,
            assigneesURL: entity.assigneesURL,
            blobsURL: entity.blobsURL,
            branchesURL: entity.branchesURL,
            collaboratorsURL: entity.collaboratorsURL,
            commentsURL: entity.commentsURL,
            commitsURL: entity.commitsURL,
            compareURL: entity.compareURL,
            contentsURL: entity.contentsURL,
            contributorsURL: entity.contributorsURL,
            deploymentsURL: entity.deploymentsURL,
            downloadsURL: entity.downloadsURL,
            eventsURL: entity.eventsURL,
            forksURL: entity.forksURL,
            gitCommitsURL: entity.gitCommitsURL,
            gitRefsURL: entity.gitRefsURL,
            gitTagsURL: entity.gitTagsURL,
            gitURL: entity.gitURL,
            issueCommentURL: entity.issueCommentURL,
            issueEventsURL: entity.issueEventsURL,
            issuesURL: entity.issuesURL,
            keysURL: entity.keysURL,
            labelsURL: entity.labelsURL,
            languagesURL: entity.languagesURL,
            mergesURL: entity.mergesURL,
            milestonesURL: entity.milestonesURL,
            notificationsURL: entity.notificationsURL,
            pullsURL: entity.pullsURL,
            releasesURL: entity.releasesURL,
            sshURL: entity.sshURL,
            stargazersURL: entity.stargazersURL,
            statusesURL: entity.statusesURL,
            subscribersURL: entity.subscribersURL,
            subscriptionURL: entity.subscriptionURL,
            tagsURL: entity.tagsURL,
            teamsURL: entity.teamsURL,
            treesURL: entity.treesURL,
            cloneURL: entity.cloneURL,
            mirrorURL: entity.mirrorURL,
            hooksURL: entity.hooksURL,
            svnURL: entity.svnURL,
            forks: entity.forks,
            openIssues: entity.openIssues,
            watchers: entity.watchers,
            hasIssues: entity.hasIssues,
            hasProjects: entity.hasProjects,
            hasPages: entity.hasPages,
            hasWiki: entity.hasWiki,
            hasDownloads: entity.hasDownloads,
            archived: entity.archived,
            disabled: entity.disabled,
            visibility: entity.visibility,
            login: entity.owner.login,
            ownerId: entity.owner.id,
            ownerNodeId: entity.owner.nodeId,
            gravatarId: entity.owner.gravatarId,
            ownerUrl: entity.owner.url,
            receivedEventsURL: entity.owner.receivedEventsURL,
            type: entity.owner.type,
            ownerHtmlURL: entity.owner.htmlURL,
            followersURL: entity.owner.followersURL,
            followingURL: entity.owner.followingURL,
            gistsURL: entity.owner.gistsURL,
            starredURL: entity.owner.starredURL,
            subscriptionsURL: entity.owner.subscriptionsURL,
            organizationsURL: entity.owner.organizationsURL,
            reposURL: entity.owner.reposURL,
            ownerEventsURL: entity.owner.eventsURL,
            siteAdmin: entity.owner.siteAdmin,
            key: entity.license?.key ?? "",
            licenseName: entity.license?.name ?? "No License",
            licenseUrl: entity.license?.url,
            spdxId: entity.license?.spdxId,
            licenseNodeId: entity.license?.nodeId ?? "",
            licenseHtmlURL: entity.license?.htmlURL
        )
    }
    
    func translate(from entity: GithubRepositoryResponseEntity) -> GithubRepositoryResponseModel {
        return .init(
            totalCount: entity.totalCount,
            incompleteResults: entity.incompleteResults,
            items: entity.items.map { translate(from: $0) }
        )
    }
}
