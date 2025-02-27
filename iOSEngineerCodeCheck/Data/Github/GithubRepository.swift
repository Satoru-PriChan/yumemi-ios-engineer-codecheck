//
//  GithubRepository.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/02/25.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit
import OSLog

protocol GithubRepositoryProtocol: Sendable {
    init(session: URLSession)
    func searchRepositories(query: String, sort: String, order: String, page: Int, perPage: Int) async throws -> GithubRepositoryResponseEntity
}

/// Github repository API caller
/// Modifier `final` is allowed before actor https://forums.swift.org/t/why-can-you-constrain-to-final-classes-and-actors/65256/3
final actor GithubRepository: GithubRepositoryProtocol {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func searchRepositories(query: String, sort: String, order: String, page: Int = 1, perPage: Int = 30) async throws -> GithubRepositoryResponseEntity {
        var components = URLComponents(string: "https://api.github.com/search/repositories")!
        components.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "sort", value: sort),
            URLQueryItem(name: "order", value: order),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "per_page", value: String(perPage))
        ]

        guard let url = components.url else {
            os_log(.error, "Invalid URL: \(components.debugDescription)")
            throw APIError.invalidURL
        }

        do {
            let (data, _) = try await session.data(from: url)
            let response = try JSONDecoder().decode(GithubRepositoryResponseEntity.self, from: data)
            return response
        } catch {
            os_log(.error, "SearchRepository Error: \(error.localizedDescription)")
            throw error
        }
    }
}
