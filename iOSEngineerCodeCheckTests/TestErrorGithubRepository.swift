//
//  TestGithubRepository.swift
//  iOSEngineerCodeCheckTests
//
//  Created by kento.yamazaki on 2025/02/26.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit
@testable
import iOSEngineerCodeCheck

// MARK: - TestErrorGithubRepository
final class TestErrorGithubRepository: GithubRepositoryProtocol {
    required init(session: URLSession) {
        // セッションは使用しない
    }
    
    func searchRepositories(query: String) async throws -> [GithubRepositoryEntity] {
        throw NSError(domain: "TestError", code: 1, userInfo: nil)
    }
    
    func fetchImage(from urlString: String) async throws -> UIImage {
        throw NSError(domain: "TestError", code: 2, userInfo: nil)
    }
}
