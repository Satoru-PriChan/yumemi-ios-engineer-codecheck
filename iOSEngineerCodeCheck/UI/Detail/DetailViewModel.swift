//
//  DetailViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/02/26.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import Combine
import Foundation
import UIKit

@MainActor
protocol DetailViewModelProtocol {
    init(repository: GithubRepositoryModel)
    var repositoryPublisher: Published<GithubRepositoryModel>.Publisher { get }
}

@MainActor
final class DetailViewModel: DetailViewModelProtocol {
    var repositoryPublisher: Published<GithubRepositoryModel>.Publisher {
        $repository
    }

    @Published var repository: GithubRepositoryModel
    private var cancellables = Set<AnyCancellable>()

    init(
        repository: GithubRepositoryModel
    ) {
        self.repository = repository
    }
}
