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
final class SearchViewModel {
    @Published var repositories: [GithubRepositoryModel] = []
    @Published var errorMessage: String?

    private let repository: GithubRepository
    private let translator: GithubRepositoryTranslator
    private var cancellables = Set<AnyCancellable>()

    init(repository: GithubRepository = GithubRepository(), translator: GithubRepositoryTranslator = GithubRepositoryTranslator()) {
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
