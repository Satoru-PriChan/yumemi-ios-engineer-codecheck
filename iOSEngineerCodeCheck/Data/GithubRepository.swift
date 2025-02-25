//
//  GithubRepository.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/02/25.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

final actor GithubRepository {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    /// GitHub リポジトリを検索する
    func searchRepositories(query: String) async throws -> [[String: any Sendable]] {
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(query)") else {
            throw NSError(domain: "Invalid URL", code: 400, userInfo: nil)
        }

        let (data, _) = try await session.data(from: url)

        guard let obj = try JSONSerialization.jsonObject(with: data) as? [String: any Sendable],
              let items = obj["items"] as? [[String: any Sendable]]
        else {
            throw NSError(domain: "Invalid Response", code: 500, userInfo: nil)
        }

        return items
    }

    /// 画像データを取得する
    func fetchImage(from urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid Image URL", code: 400, userInfo: nil)
        }

        let (data, _) = try await session.data(from: url)
        guard let image = UIImage(data: data) else {
            throw NSError(domain: "Invalid Image Data", code: 404, userInfo: nil)
        }

        return image
    }
}
