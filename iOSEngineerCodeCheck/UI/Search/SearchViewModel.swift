//
//  SearchViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/02/26.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//
import Combine
import Foundation

@MainActor
protocol SearchViewModelProtocol: ObservableObject {
    var totalCount: Int? { get }
    var repositories: [GithubRepositoryModel] { get }
    var isLoading: Bool { get }
    var onError: ((String) -> Void)? { get set }
    func searchRepositories(query: String) async
    func showDetail(repository: GithubRepositoryModel)
}

@MainActor
final class SearchViewModel: SearchViewModelProtocol {
    @Published var totalCount: Int? = nil
    @Published var repositories: [GithubRepositoryModel] = []
    @Published var isLoading: Bool = false
    var onError: ((String) -> Void)?

    private let repository: GithubRepositoryProtocol
    private let translator: GithubRepositoryTranslatorProtocol

    init(repository: GithubRepositoryProtocol = GithubRepository(), translator: GithubRepositoryTranslatorProtocol = GithubRepositoryTranslator()) {
        self.repository = repository
        self.translator = translator
    }

    func searchRepositories(query: String) async {
        guard !query.isEmpty else { return }
        isLoading = true
        do {
            let responseEntity = try await repository.searchRepositories(query: query)
            let responseModel = translator.translate(from: responseEntity)
            repositories = responseModel.items
            totalCount = responseModel.totalCount
        } catch {
            onError?("エラーが発生しました")
        }
        isLoading = false
    }

    func showDetail(repository: GithubRepositoryModel) {
        // Navigate to detail view (can be implemented using NavigationLink or a coordinator)
        print("Navigating to detail for \(repository.fullName)")
    }
}
