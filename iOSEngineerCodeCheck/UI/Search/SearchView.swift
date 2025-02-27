//
//  SearchView.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel(
        repository: GithubRepository(),
        translator: GithubRepositoryTranslator()
    )
    @State private var searchText = ""
    @State private var isShowingErrorAlert = false
    @State private var errorMessage = ""
    @State private var navigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                // Search Bar
                TextField("Search Github Repositories...", text: $searchText, onCommit: performSearch)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .accessibilityIdentifier("SearchView_SearchBar")

                // Repository List
                List(viewModel.repositories) { repository in
                    Button(action: {
                        navigationPath.append(repository) // Navigate to DetailView
                    }) {
                        VStack(alignment: .leading) {
                            Text(repository.fullName)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(Color(UIColor.label))
                            Text("\(repository.stargazersCount) Star")
                                .font(.system(size: 14, weight: .thin))
                                .foregroundColor(Color(UIColor.secondaryLabel))
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Github Repositories")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.editor)//Hide back button text
            .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
            .loadingIndicator(isShowing: Binding<Bool>(
                get: { viewModel.isLoading },
                set: { _ in }
            ))
            .alert(isPresented: $isShowingErrorAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            .navigationDestination(for: GithubRepositoryModel.self) { repository in
                DetailView(repository: repository)
            }
        }
        .tint(Color(UIColor.label))
        .onAppear {
            viewModel.onError = { message in
                errorMessage = message
                isShowingErrorAlert = true
            }
        }
    }

    private func performSearch() {
        Task {
            await viewModel.searchRepositories(query: searchText)
        }
    }
}
