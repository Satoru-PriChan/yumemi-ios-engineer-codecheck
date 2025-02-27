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
protocol SearchViewModelProtocol {
    init(repository: GithubRepositoryProtocol, translator: GithubRepositoryTranslatorProtocol)
    var repositoriesPublisher: Published<[GithubRepositoryModel]>.Publisher { get }
    var repositories: [GithubRepositoryModel] { get }
    var errorMessagePublisher: Published<String?>.Publisher { get }
    var isLoadingPublisher: Published<Bool>.Publisher { get }
    func searchRepositories(query: String) async
}

@MainActor
final class SearchViewModel: SearchViewModelProtocol {
    var repositoriesPublisher: Published<[GithubRepositoryModel]>.Publisher { $repositories }
    var errorMessagePublisher: Published<String?>.Publisher { $errorMessage }
    var isLoadingPublisher: Published<Bool>.Publisher { $isLoading }
    @Published var repositories: [GithubRepositoryModel] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false

    private let repository: GithubRepositoryProtocol
    private let translator: GithubRepositoryTranslatorProtocol
    private var cancellables = Set<AnyCancellable>()

    init(repository: GithubRepositoryProtocol = GithubRepository(), translator: GithubRepositoryTranslatorProtocol = GithubRepositoryTranslator()) {
        self.repository = repository
        self.translator = translator
    }

    func searchRepositories(query: String) async {
        isLoading = true
        do {
            let entities = try await repository.searchRepositories(query: query)
            DispatchQueue.main.async {
                self.repositories = self.translator.translate(from: entities)
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "エラーが発生しました"
                self.isLoading = false
            }
        }
    }
}
