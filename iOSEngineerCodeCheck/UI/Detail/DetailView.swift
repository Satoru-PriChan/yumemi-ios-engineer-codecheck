//
//  DetailView.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/02/28.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import Kingfisher
import SwiftUI

struct DetailView: View {
    @StateObject private var viewModel: DetailViewModel
    @State private var isAnimated = false

    init(repository: GithubRepositoryModel) {
        _viewModel = StateObject(wrappedValue: DetailViewModel(repository: repository))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Repository Image
                KFImage(URL(string: viewModel.repository.avatarURL))
                    .onFailureImage(KFCrossPlatformImage(resource: R.image.imageBreak))
                    .placeholder { ProgressView() }
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)

                // Repository Title
                Text(viewModel.repository.fullName)
                    .font(.largeTitle)
                    .foregroundColor(Color(UIColor.label))
                    .accessibilityIdentifier("DetailView_TitleLabel")

                // Language
                Text("Written in \(viewModel.repository.language)")
                    .font(.body)
                    .foregroundColor(Color(UIColor.secondaryLabel))
                    .accessibilityIdentifier("DetailView_LanguageLabel")

                // Stats Section
                VStack(alignment: .leading, spacing: 8) {
                    StatRow(image: "star", label: "Stars", count: viewModel.repository.stargazersCount, accessibilityIdentifier: "DetailView_StarsLabel")
                    StatRow(image: "eye", label: "Watchers", count: viewModel.repository.watchersCount, accessibilityIdentifier: "DetailView_WatchersLabel")
                    StatRow(image: "tuningfork", label: "Forks", count: viewModel.repository.forksCount, accessibilityIdentifier: "DetailView_ForksLabel")
                    StatRow(image: "book.circle", label: "Open Issues", count: viewModel.repository.openIssuesCount, accessibilityIdentifier: "DetailView_OpenIssuesLabel")
                }

                // Additional Properties Section
                VStack(alignment: .leading, spacing: 8) {
                    SectionHeader(title: "Additional Information")

                    // String, Int, Bool Properties
                    InfoRow(label: "Repository ID", value: String(viewModel.repository.repositoryID))
                    InfoRow(label: "Name", value: viewModel.repository.name)
                    InfoRow(label: "Description", value: viewModel.repository.description ?? "N/A")
                    InfoRow(label: "Private", value: viewModel.repository.isPrivate ? "Yes" : "No")
                    InfoRow(label: "Default Branch", value: viewModel.repository.defaultBranch)
                    InfoRow(label: "Score", value: String(viewModel.repository.score))
                    InfoRow(label: "Size", value: String(viewModel.repository.size))
                    InfoRow(label: "Homepage", value: viewModel.repository.homepage ?? "N/A")
                    InfoRow(label: "Master Branch", value: viewModel.repository.masterBranch ?? "N/A")
                    InfoRow(label: "Archived", value: viewModel.repository.archived ? "Yes" : "No")
                    InfoRow(label: "Disabled", value: viewModel.repository.disabled ? "Yes" : "No")
                    InfoRow(label: "Visibility", value: viewModel.repository.visibility)
                    InfoRow(label: "Forks", value: String(viewModel.repository.forks))
                    InfoRow(label: "Open Issues", value: String(viewModel.repository.openIssues))
                    InfoRow(label: "Watchers", value: String(viewModel.repository.watchers))
                    InfoRow(label: "Has Issues", value: viewModel.repository.hasIssues ? "Yes" : "No")
                    InfoRow(label: "Has Projects", value: viewModel.repository.hasProjects ? "Yes" : "No")
                    InfoRow(label: "Has Pages", value: viewModel.repository.hasPages ? "Yes" : "No")
                    InfoRow(label: "Has Wiki", value: viewModel.repository.hasWiki ? "Yes" : "No")
                    InfoRow(label: "Has Downloads", value: viewModel.repository.hasDownloads ? "Yes" : "No")

                    // Owner Information
                    SectionHeader(title: "Owner Information")
                    InfoRow(label: "Login", value: viewModel.repository.login)
                    InfoRow(label: "Owner ID", value: String(viewModel.repository.ownerId))
                    InfoRow(label: "Owner Node ID", value: viewModel.repository.ownerNodeId)
                    InfoRow(label: "Gravatar ID", value: viewModel.repository.gravatarId ?? "N/A")
                    InfoRow(label: "Type", value: viewModel.repository.type)
                    InfoRow(label: "Site Admin", value: viewModel.repository.siteAdmin ? "Yes" : "No")

                    // License Information
                    SectionHeader(title: "License Information")
                    InfoRow(label: "License Key", value: viewModel.repository.key)
                    InfoRow(label: "License Name", value: viewModel.repository.licenseName)
                    InfoRow(label: "SPDX ID", value: viewModel.repository.spdxId ?? "N/A")
                    InfoRow(label: "License Node ID", value: viewModel.repository.licenseNodeId)

                    // URL Properties
                    SectionHeader(title: "URLs")
                    URLRow(label: "HTML URL", url: viewModel.repository.htmlURLAsURL)
                    URLRow(label: "API URL", url: viewModel.repository.urlAsURL)
                    URLRow(label: "Avatar URL", url: viewModel.repository.avatarURLAsURL)
                    URLRow(label: "Archive URL", url: viewModel.repository.archiveURLAsURL)
                    URLRow(label: "Assignees URL", url: viewModel.repository.assigneesURLAsURL)
                    URLRow(label: "Blobs URL", url: viewModel.repository.blobsURLAsURL)
                    URLRow(label: "Branches URL", url: viewModel.repository.branchesURLAsURL)
                    URLRow(label: "Collaborators URL", url: viewModel.repository.collaboratorsURLAsURL)
                    URLRow(label: "Comments URL", url: viewModel.repository.commentsURLAsURL)
                    URLRow(label: "Commits URL", url: viewModel.repository.commitsURLAsURL)
                    URLRow(label: "Compare URL", url: viewModel.repository.compareURLAsURL)
                    URLRow(label: "Contents URL", url: viewModel.repository.contentsURLAsURL)
                    URLRow(label: "Contributors URL", url: viewModel.repository.contributorsURLAsURL)
                    URLRow(label: "Deployments URL", url: viewModel.repository.deploymentsURLAsURL)
                    URLRow(label: "Downloads URL", url: viewModel.repository.downloadsURLAsURL)
                    URLRow(label: "Events URL", url: viewModel.repository.eventsURLAsURL)
                    URLRow(label: "Forks URL", url: viewModel.repository.forksURLAsURL)
                    URLRow(label: "Git Commits URL", url: viewModel.repository.gitCommitsURLAsURL)
                    URLRow(label: "Git Refs URL", url: viewModel.repository.gitRefsURLAsURL)
                    URLRow(label: "Git Tags URL", url: viewModel.repository.gitTagsURLAsURL)
                    URLRow(label: "Git URL", url: viewModel.repository.gitURLAsURL)
                    URLRow(label: "Issue Comment URL", url: viewModel.repository.issueCommentURLAsURL)
                    URLRow(label: "Issue Events URL", url: viewModel.repository.issueEventsURLAsURL)
                    URLRow(label: "Issues URL", url: viewModel.repository.issuesURLAsURL)
                    URLRow(label: "Keys URL", url: viewModel.repository.keysURLAsURL)
                    URLRow(label: "Labels URL", url: viewModel.repository.labelsURLAsURL)
                    URLRow(label: "Languages URL", url: viewModel.repository.languagesURLAsURL)
                    URLRow(label: "Merges URL", url: viewModel.repository.mergesURLAsURL)
                    URLRow(label: "Milestones URL", url: viewModel.repository.milestonesURLAsURL)
                    URLRow(label: "Notifications URL", url: viewModel.repository.notificationsURLAsURL)
                    URLRow(label: "Pulls URL", url: viewModel.repository.pullsURLAsURL)
                    URLRow(label: "Releases URL", url: viewModel.repository.releasesURLAsURL)
                    URLRow(label: "SSH URL", url: viewModel.repository.sshURLAsURL)
                    URLRow(label: "Stargazers URL", url: viewModel.repository.stargazersURLAsURL)
                    URLRow(label: "Statuses URL", url: viewModel.repository.statusesURLAsURL)
                    URLRow(label: "Subscribers URL", url: viewModel.repository.subscribersURLAsURL)
                    URLRow(label: "Subscription URL", url: viewModel.repository.subscriptionURLAsURL)
                    URLRow(label: "Tags URL", url: viewModel.repository.tagsURLAsURL)
                    URLRow(label: "Teams URL", url: viewModel.repository.teamsURLAsURL)
                    URLRow(label: "Trees URL", url: viewModel.repository.treesURLAsURL)
                    URLRow(label: "Clone URL", url: viewModel.repository.cloneURLAsURL)
                    URLRow(label: "Mirror URL", url: viewModel.repository.mirrorURLAsURL)
                    URLRow(label: "Hooks URL", url: viewModel.repository.hooksURLAsURL)
                    URLRow(label: "SVN URL", url: viewModel.repository.svnURLAsURL)
                    URLRow(label: "Owner URL", url: viewModel.repository.ownerUrlAsURL)
                    URLRow(label: "Received Events URL", url: viewModel.repository.receivedEventsURLAsURL)
                    URLRow(label: "Owner HTML URL", url: viewModel.repository.ownerHtmlURLAsURL)
                    URLRow(label: "Followers URL", url: viewModel.repository.followersURLAsURL)
                    URLRow(label: "Following URL", url: viewModel.repository.followingURLAsURL)
                    URLRow(label: "Gists URL", url: viewModel.repository.gistsURLAsURL)
                    URLRow(label: "Starred URL", url: viewModel.repository.starredURLAsURL)
                    URLRow(label: "Subscriptions URL", url: viewModel.repository.subscriptionsURLAsURL)
                    URLRow(label: "Organizations URL", url: viewModel.repository.organizationsURLAsURL)
                    URLRow(label: "Repos URL", url: viewModel.repository.reposURLAsURL)
                    URLRow(label: "Owner Events URL", url: viewModel.repository.ownerEventsURLAsURL)
                    URLRow(label: "License URL", url: viewModel.repository.licenseUrlAsURL)
                    URLRow(label: "License HTML URL", url: viewModel.repository.licenseHtmlURLAsURL)
                }
                .padding(.top, 16)
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            .opacity(isAnimated ? 1 : 0.1)
            .animation(.easeInOut(duration: 0.5).delay(0.2), value: isAnimated)
        }
        .navigationTitle("Repository Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor) // Hide back button text
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isAnimated = true
            }
        }
    }
}

// MARK: - Section Header Component

struct SectionHeader: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(Color(UIColor.label))
            .padding(.vertical, 8)
    }
}

// MARK: - StatRow Component

struct StatRow: View {
    let image: String
    let label: String
    let count: Int
    let accessibilityIdentifier: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 22, height: 22)
                .font(.title3)
                .foregroundColor(Color(UIColor.label))
            Text(label)
                .font(.subheadline)
                .foregroundColor(Color(UIColor.secondaryLabel)).accessibilityIdentifier(accessibilityIdentifier)
            Spacer()
            Text("\(count)")
                .font(fontForCount(count: count))
                .foregroundColor(Color(UIColor.label))
        }
    }

    private func fontForCount(count: Int) -> Font { if count > 10000 { return .system(size: 18, weight: .heavy) } else if count > 1000 { return .system(size: 17, weight: .bold) } else if count > 100 { return .system(size: 16, weight: .medium) } else { return .system(size: 14, weight: .light) } }
}

// MARK: - InfoRow Component

struct InfoRow: View {
    let label: String
    let value: String
    @State private var shouldShowCopyAlert = false

    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .foregroundColor(Color(UIColor.secondaryLabel))
            Spacer()
            Text(value)
                .font(.subheadline)
                .foregroundColor(Color(UIColor.label))
            Button(action: {
                UIPasteboard.general.string = value
                shouldShowCopyAlert = true
            }) {
                Image(systemName: "doc.on.doc")
                    .foregroundColor(Color(UIColor.label))
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .alert(isPresented: $shouldShowCopyAlert) {
            Alert(
                title: Text("Notice"),
                message: Text("Copy Completed!"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

// MARK: - URLRow Component

struct URLRow: View {
    let label: String
    let url: URL?
    @State private var shouldShowCopyAlert = false

    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .foregroundColor(Color(UIColor.label))
            Spacer()
            if let url = url {
                Link(destination: url) {
                    Text(url.absoluteString)
                        .font(.subheadline)
                        .foregroundColor(Color.blue)
                        .underline()
                }
                Button(action: {
                    UIPasteboard.general.string = url.absoluteString
                    shouldShowCopyAlert = true
                }) {
                    Image(systemName: "doc.on.doc")
                        .foregroundColor(Color(UIColor.label))
                }
                .buttonStyle(BorderlessButtonStyle())
            } else {
                Text("N/A")
                    .font(.subheadline)
                    .foregroundColor(Color(UIColor.secondaryLabel))
            }
        }
        .alert(isPresented: $shouldShowCopyAlert) {
            Alert(
                title: Text("Notice"),
                message: Text("Copy Completed!"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
