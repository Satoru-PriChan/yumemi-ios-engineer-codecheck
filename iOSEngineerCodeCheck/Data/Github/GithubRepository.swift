//
//  GithubRepository.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/02/25.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

protocol GithubRepositoryProtocol: Sendable {
    init(session: URLSession)
    func searchRepositories(query: String) async throws -> GithubRepositoryResponseEntity
}

/// Github repository API caller
/// Modifier `final` is allowed before actor https://forums.swift.org/t/why-can-you-constrain-to-final-classes-and-actors/65256/3
final actor GithubRepository: GithubRepositoryProtocol {
    private let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }

    func searchRepositories(query: String) async throws -> GithubRepositoryResponseEntity {
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(query)") else {
            throw APIError.invalidURL
        }
        let (data, _) = try await session.data(from: url)
        let response = try JSONDecoder().decode(GithubRepositoryResponseEntity.self, from: data)
        return response
    }
}
