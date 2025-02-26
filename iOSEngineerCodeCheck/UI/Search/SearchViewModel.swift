//
//  SearchViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/02/26.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import Foundation
import Combine

@MainActor
protocol SearchViewModelProtocol {
    init(repository: GithubRepositoryProtocol, translator: GithubRepositoryTranslatorProtocol)
    var repositoriesPublisher: Published<[GithubRepositoryModel]>.Publisher { get }
    var repositories: [GithubRepositoryModel] { get }
    var errorMessagePublisher: Published<String?>.Publisher { get }
    func searchRepositories(query: String) async
}

@MainActor
final class SearchViewModel: SearchViewModelProtocol {
    var repositoriesPublisher: Published<[GithubRepositoryModel]>.Publisher { $repositories }
    var errorMessagePublisher: Published<String?>.Publisher { $errorMessage }
    @Published var repositories: [GithubRepositoryModel] = []
    @Published var errorMessage: String?

    private let repository: GithubRepositoryProtocol
    private let translator: GithubRepositoryTranslatorProtocol
    private var cancellables = Set<AnyCancellable>()

    init(repository: GithubRepositoryProtocol = GithubRepository(), translator: GithubRepositoryTranslatorProtocol = GithubRepositoryTranslator()) {
        self.repository = repository
        self.translator = translator
    }

    func searchRepositories(query: String) async {
        do {
            let entities = try await self.repository.searchRepositories(query: query)
            DispatchQueue.main.async {
                self.repositories = self.translator.translate(from: entities)
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "エラーが発生しました"
            }
        }
    }
}
