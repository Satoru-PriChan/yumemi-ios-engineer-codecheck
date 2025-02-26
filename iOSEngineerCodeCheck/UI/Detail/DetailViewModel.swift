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
    init(repository: GithubRepositoryModel, githubRepository: GithubRepositoryProtocol)
    var repositoryPublisher: Published<GithubRepositoryModel>.Publisher { get }
    var avatarImagePublisher: Published<UIImage?>.Publisher { get }
    var errorMessagePublisher: Published<String?>.Publisher { get }
    func fetchAvatarImage() async
}

@MainActor
final class DetailViewModel: DetailViewModelProtocol {
    var repositoryPublisher: Published<GithubRepositoryModel>.Publisher {
        $repository
    }
    var avatarImagePublisher: Published<UIImage?>.Publisher {
        $avatarImage
    }
    var errorMessagePublisher: Published<String?>.Publisher {
        $errorMessage
    }
    
    @Published var repository: GithubRepositoryModel
    @Published var avatarImage: UIImage?
    @Published var errorMessage: String?

    private let githubRepository: GithubRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()

    init(
        repository: GithubRepositoryModel,
        githubRepository: GithubRepositoryProtocol = GithubRepository()
    ) {
        self.repository = repository
        self.githubRepository = githubRepository
    }

    func fetchAvatarImage() async {
        do {
            let image = try await self.githubRepository.fetchImage(from: self.repository.avatarURL)
            DispatchQueue.main.async {
                self.avatarImage = image
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "画像の取得に失敗しました"
            }
        }
    }
}
