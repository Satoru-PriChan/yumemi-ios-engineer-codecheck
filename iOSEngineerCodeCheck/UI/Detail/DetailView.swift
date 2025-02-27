//
//  DetailView.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
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
                .foregroundColor(Color(UIColor.secondaryLabel))
                .accessibilityIdentifier(accessibilityIdentifier)
            Spacer()
            Text("\(count)")
                .font(fontForCount(count))
                .foregroundColor(Color(UIColor.label))
        }
    }

    private func fontForCount(_ count: Int) -> Font {
        if count > 10000 {
            return .system(size: 18, weight: .bold)
        } else if count > 1000 {
            return .system(size: 17, weight: .heavy)
        } else if count > 100 {
            return .system(size: 16, weight: .medium)
        } else {
            return .system(size: 14, weight: .light)
        }
    }
}
