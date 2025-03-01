//
//  SearchViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/02/26.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import Combine
import Foundation
import OSLog

@MainActor
protocol SearchViewModelProtocol: ObservableObject {
    var totalCount: Int? { get }
    var repositories: [GithubRepositoryModel] { get }
    var isLoading: Bool { get }
    var isLoadingNextPage: Bool { get }
    var onError: ((String) -> Void)? { get set }
    func searchRepositories(query: String, sort: String, order: String, perPage: Int) async
    func loadNextPage() async
    func resetPagination()
}

@MainActor
final class SearchViewModel: SearchViewModelProtocol {
    @Published var totalCount: Int? = nil
    @Published var repositories: [GithubRepositoryModel] = []
    @Published var isLoading: Bool = false
    @Published var isLoadingNextPage: Bool = false
    var onError: ((String) -> Void)?
    private let repository: GithubRepositoryProtocol
    private let translator: GithubRepositoryTranslatorProtocol
    private var currentPage: Int = 1
    private var currentQuery: String = ""
    private var currentSort: String = "stars"
    private var currentOrder: String = "desc"
    private var currentPerPage: Int = 30

    init(repository: GithubRepositoryProtocol = GithubRepository(), translator: GithubRepositoryTranslatorProtocol = GithubRepositoryTranslator()) {
        self.repository = repository
        self.translator = translator
    }

    func searchRepositories(query: String, sort: String, order: String, perPage: Int) async {
        guard !query.isEmpty else { return }
        isLoading = true
        currentPage = 1
        currentQuery = query
        currentSort = sort
        currentOrder = order
        currentPerPage = perPage

        do {
            let responseEntity = try await repository.searchRepositories(
                query: query,
                sort: sort,
                order: order,
                page: currentPage,
                perPage: perPage
            )
            let responseModel = translator.translate(from: responseEntity)
            repositories = responseModel.items
            totalCount = responseModel.totalCount
        } catch {
            os_log(.error, "\(error.localizedDescription)")
            onError?("エラーが発生しました")
        }
        isLoading = false
    }

    func loadNextPage() async {
        guard !currentQuery.isEmpty else { return }
        isLoadingNextPage = true
        currentPage += 1

        do {
            let responseEntity = try await repository.searchRepositories(
                query: currentQuery,
                sort: currentSort,
                order: currentOrder,
                page: currentPage,
                perPage: currentPerPage
            )
            let responseModel = translator.translate(from: responseEntity)
            repositories.append(contentsOf: responseModel.items)
        } catch {
            os_log(.error, "\(error.localizedDescription)")
            onError?("ページの読み込みに失敗しました")
        }
        isLoadingNextPage = false
    }

    func resetPagination() {
        currentPage = 1
        repositories.removeAll()
    }
}
