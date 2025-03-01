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
            repositoryID: entity.id ?? 0,
            fullName: entity.fullName ?? "N/A",
            language: entity.language ?? "Unknown Language",
            stargazersCount: entity.stargazersCount ?? 0,
            watchersCount: entity.watchersCount ?? 0,
            forksCount: entity.forksCount ?? 0,
            openIssuesCount: entity.openIssuesCount ?? 0,
            avatarURL: entity.owner?.avatarURL ?? "N/A",
            nodeId: entity.nodeId ?? "N/A",
            name: entity.name ?? "N/A",
            isPrivate: entity.isPrivate ?? false,
            htmlURL: entity.htmlURL ?? "N/A",
            description: entity.description,
            isFork: entity.isFork ?? false,
            url: entity.url ?? "N/A",
            createdAt: entity.createdAt ?? "N/A",
            updatedAt: entity.updatedAt ?? "N/A",
            pushedAt: entity.pushedAt ?? "N/A",
            homepage: entity.homepage ?? "N/A",
            size: entity.size ?? 0,
            masterBranch: entity.masterBranch ?? "N/A",
            defaultBranch: entity.defaultBranch ?? "N/A",
            score: entity.score ?? 0,
            archiveURL: entity.archiveURL ?? "N/A",
            assigneesURL: entity.assigneesURL ?? "N/A",
            blobsURL: entity.blobsURL ?? "N/A",
            branchesURL: entity.branchesURL ?? "N/A",
            collaboratorsURL: entity.collaboratorsURL ?? "N/A",
            commentsURL: entity.commentsURL ?? "N/A",
            commitsURL: entity.commitsURL ?? "N/A",
            compareURL: entity.compareURL ?? "N/A",
            contentsURL: entity.contentsURL ?? "N/A",
            contributorsURL: entity.contributorsURL ?? "N/A",
            deploymentsURL: entity.deploymentsURL ?? "N/A",
            downloadsURL: entity.downloadsURL ?? "N/A",
            eventsURL: entity.eventsURL ?? "N/A",
            forksURL: entity.forksURL ?? "N/A",
            gitCommitsURL: entity.gitCommitsURL ?? "N/A",
            gitRefsURL: entity.gitRefsURL ?? "N/A",
            gitTagsURL: entity.gitTagsURL ?? "N/A",
            gitURL: entity.gitURL ?? "N/A",
            issueCommentURL: entity.issueCommentURL ?? "N/A",
            issueEventsURL: entity.issueEventsURL ?? "N/A",
            issuesURL: entity.issuesURL ?? "N/A",
            keysURL: entity.keysURL ?? "N/A",
            labelsURL: entity.labelsURL ?? "N/A",
            languagesURL: entity.languagesURL ?? "N/A",
            mergesURL: entity.mergesURL ?? "N/A",
            milestonesURL: entity.milestonesURL ?? "N/A",
            notificationsURL: entity.notificationsURL ?? "N/A",
            pullsURL: entity.pullsURL ?? "N/A",
            releasesURL: entity.releasesURL ?? "N/A",
            sshURL: entity.sshURL ?? "N/A",
            stargazersURL: entity.stargazersURL ?? "N/A",
            statusesURL: entity.statusesURL ?? "N/A",
            subscribersURL: entity.subscribersURL ?? "N/A",
            subscriptionURL: entity.subscriptionURL ?? "N/A",
            tagsURL: entity.tagsURL ?? "N/A",
            teamsURL: entity.teamsURL ?? "N/A",
            treesURL: entity.treesURL ?? "N/A",
            cloneURL: entity.cloneURL ?? "N/A",
            mirrorURL: entity.mirrorURL,
            hooksURL: entity.hooksURL ?? "N/A",
            svnURL: entity.svnURL ?? "N/A",
            forks: entity.forks ?? 0,
            openIssues: entity.openIssues ?? 0,
            watchers: entity.watchers ?? 0,
            hasIssues: entity.hasIssues ?? false,
            hasProjects: entity.hasProjects ?? false,
            hasPages: entity.hasPages ?? false,
            hasWiki: entity.hasWiki ?? false,
            hasDownloads: entity.hasDownloads ?? false,
            archived: entity.archived ?? false,
            disabled: entity.disabled ?? false,
            visibility: entity.visibility ?? "N/A",
            login: entity.owner?.login ?? "N/A",
            ownerId: entity.owner?.id ?? 0,
            ownerNodeId: entity.owner?.nodeId ?? "N/A",
            gravatarId: entity.owner?.gravatarId,
            ownerUrl: entity.owner?.url ?? "N/A",
            receivedEventsURL: entity.owner?.receivedEventsURL ?? "N/A",
            type: entity.owner?.type ?? "N/A",
            ownerHtmlURL: entity.owner?.htmlURL ?? "N/A",
            followersURL: entity.owner?.followersURL ?? "N/A",
            followingURL: entity.owner?.followingURL ?? "N/A",
            gistsURL: entity.owner?.gistsURL ?? "N/A",
            starredURL: entity.owner?.starredURL ?? "N/A",
            subscriptionsURL: entity.owner?.subscriptionsURL ?? "N/A",
            organizationsURL: entity.owner?.organizationsURL ?? "N/A",
            reposURL: entity.owner?.reposURL ?? "N/A",
            ownerEventsURL: entity.owner?.eventsURL ?? "N/A",
            siteAdmin: entity.owner?.siteAdmin ?? false,
            key: entity.license?.key ?? "",
            licenseName: entity.license?.name ?? "No License",
            licenseUrl: entity.license?.url,
            spdxId: entity.license?.spdxId,
            licenseNodeId: entity.license?.nodeId ?? "",
            licenseHtmlURL: entity.license?.htmlURL
        )
    }

    func translate(from entity: GithubRepositoryResponseEntity) -> GithubRepositoryResponseModel {
        let items = entity.items ?? []
        return .init(
            totalCount: entity.totalCount ?? 0,
            incompleteResults: entity.incompleteResults ?? true,
            items: items.map {
                translate(from: $0)
            }
        )
    }
}
