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
    @State private var selectedSort: SearchSortType = .stars
    @State private var selectedOrder: SearchOrderType = .desc
    @State private var selectedPerPage: SearchPerPageType = .thirty
    @State private var isShowingSearchCondition = false

    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                searchField
                if let totalCount = viewModel.totalCount {
                    TotalCountLabel(totalCount: totalCount)
                }
                list
            }
            .navigationTitle("Github Repositories")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingSearchCondition = true
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .foregroundColor(Color(UIColor.secondaryLabel))
                    }
                }
            }
            .sheet(isPresented: $isShowingSearchCondition) {
                SearchConditionView(
                    selectedSort: $selectedSort,
                    selectedOrder: $selectedOrder,
                    selectedPerPage: $selectedPerPage
                )
                .presentationDetents([.medium]) // モーダルのサイズを調整
            }
            .toolbarRole(.editor) // Hide back button text
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

    private var searchField: some View {
        TextField("Search Github Repositories...", text: $searchText, onCommit: performSearch)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .background(Color(UIColor.systemBackground))
            .cornerRadius(10)
            .padding(.horizontal)
            .accessibilityIdentifier("SearchView_SearchBar")
    }

    private var list: some View {
        List {
            ForEach(viewModel.repositories) { repository in
                Button(action: {
                    navigationPath.append(repository) // Navigate to DetailView
                }) {
                    SearchListRow(
                        repositoryName: repository.name,
                        stargazersCount: repository.stargazersCount,
                        languageColor: repository.languageType?.color ?? .gray,
                        languageName: repository.language,
                        description: repository.description
                    )
                    .padding(.vertical, 8)
                }
            }
            if viewModel.repositories.count > 0 {
                SearchListFooterView {
                    Task {
                        await viewModel.loadNextPage()
                    }
                }
            }
        }
        .listStyle(PlainListStyle())
        .refreshable {
            resetAndSearch()
        }
    }

    private func performSearch() {
        Task {
            await viewModel.searchRepositories(
                query: searchText,
                sort: selectedSort.rawValue,
                order: selectedOrder.rawValue,
                perPage: selectedPerPage.rawValue
            )
        }
    }

    private func resetAndSearch() {
        viewModel.resetPagination()
        performSearch()
    }
}

struct TotalCountLabel: View {
    let totalCount: Int

    var body: some View {
        Text("\(totalCount) results found")
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(Color(UIColor.secondaryLabel))
            .padding(.top, 8)
            .padding(.horizontal)
    }
}

struct SearchListRow: View {
    let repositoryName: String
    let stargazersCount: Int
    let languageColor: Color
    let languageName: String
    let description: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // repository name
            Text(repositoryName)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color(UIColor.label))

            // stars
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text("\(stargazersCount) Star")
                    .font(.system(size: 14, weight: .thin))
                    .foregroundColor(Color(UIColor.secondaryLabel))
            }

            // language
            HStack {
                Image(systemName: "circle.fill")
                    .foregroundColor(languageColor)
                    .font(.system(size: 8))
                Text(languageName)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color(UIColor.secondaryLabel))
            }

            // description
            if let description = description {
                Text(description)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color(UIColor.secondaryLabel))
                    .lineLimit(1)
            } else {
                Text("No description available")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color(UIColor.secondaryLabel))
            }
        }
    }
}
