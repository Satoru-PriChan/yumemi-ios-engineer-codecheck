//
//  ComparisonView.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/03/01.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct ComparisonView: View {
    @StateObject private var viewModel: ComparisonViewModel
    @State private var isShowingErrorAlert = false
    @State private var errorMessage = ""
    @State private var navigationPath = NavigationPath()
    
    init(
        repositoryModel: GithubRepositoryModel,
        githubRepository: GithubRepositoryProtocol = GithubRepository(),
        translator: GithubRepositoryTranslatorProtocol = GithubRepositoryTranslator()
    ) {
        _viewModel = StateObject(
            wrappedValue: ComparisonViewModel(
                repositoryModel: repositoryModel,
                githubRepository: githubRepository,
                translator: translator
            )
        )
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            root
            .navigationTitle("Similar Repositories")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.editor) // Hide back button text
            .loadingIndicator(isShowing: Binding<Bool>(
                get: { viewModel.isLoading },
                set: { _ in }
            ))
            .navigationDestination(for: GithubRepositoryModel.self) { repository in
                DetailView(repository: repository, shouldShowComparisonButton: false)
            }
            .alert(isPresented: $isShowingErrorAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            .onAppear {
                viewModel.onError = { message in
                    errorMessage = message
                    isShowingErrorAlert = true
                }
                Task {
                    try await viewModel.fetchSimilarRepositories()
                }
            }
        }
    }
    
    private var root: some View {
        VStack(alignment: .leading, spacing: 16) {
            if viewModel.comparisonModels.isEmpty {
                Text("No similar repositories found.")
                    .font(.headline)
                    .foregroundColor(.secondary)
            } else {
                List {
                    ForEach(viewModel.comparisonModels) { comparisonModel in
                        ComparisonListRow(model: comparisonModel, onTap: { repository in
                            navigationPath.append(repository)
                        })
                    }
                }
            }
        }
    }
}

struct ComparisonListRow: View {
    let model: ComparisonModel
    let onTap: (GithubRepositoryModel) -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(model.repository.name)
                    .font(.headline)
                Text(model.repository.description ?? "No description")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("Similarity Score: \(String(format: "%.2f", model.similarityScore))")
                    .font(.title2)
                    .foregroundColor(Color(R.color.darkBlueColor))
            }
            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .contentShape(Rectangle())
        .onTapGesture { _ in
            onTap(model.repository)
        }
    }
}
