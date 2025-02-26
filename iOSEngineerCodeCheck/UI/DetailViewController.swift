//
//  DetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    // MARK: - Properties

    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var languageLabel: UILabel!
    @IBOutlet private var starsLabel: UILabel!
    @IBOutlet private var watchersLabel: UILabel!
    @IBOutlet private var forksLabel: UILabel!
    @IBOutlet private var openIssuesLabel: UILabel!

    weak var searchViewController: SearchViewController?

    private let githubRepository = GithubRepository()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        Task {
            await fetchAndSetImage()
        }
    }

    // MARK: - Private functions

    /// Query function
    private func fetchSelectedRepository() -> GithubRepositoryModel? {
        guard let selectedIndex = searchViewController?.selectedIndex,
              searchViewController?.fetchedRepositories.indices.contains(selectedIndex) ?? false,
              let selectedRepository = searchViewController?.fetchedRepositories[selectedIndex] else { return nil }
        return selectedRepository
    }

    /// Command function
    private func updateUI(with repository: GithubRepositoryModel) {
        titleLabel.text = repository.fullName
        languageLabel.text = "Written in \(repository.language ?? "Unknown Language")"
        starsLabel.text = "\(repository.stargazersCount) stars"
        watchersLabel.text = "\(repository.watchersCount) watchers"
        forksLabel.text = "\(repository.forksCount) forks"
        openIssuesLabel.text = "\(repository.openIssuesCount) open issues"
    }

    private func configureView() {
        guard let repository = fetchSelectedRepository() else { return }
        updateUI(with: repository)
    }

    // MARK: - Private functions - Images

    private func fetchImage(from urlString: String) async throws -> UIImage {
        return try await githubRepository.fetchImage(from: urlString)
    }

    private func setImage(to imageView: UIImageView, image: UIImage?) {
        imageView.image = image
    }

    private func fetchAndSetImage() async {
        guard let selectedIndex = searchViewController?.selectedIndex,
              searchViewController?.fetchedRepositories.indices.contains(selectedIndex) ?? false,
              let owner = searchViewController?.fetchedRepositories[selectedIndex].owner
        else {
            await MainActor.run {
                self.showErrorAlert()
            }
            return
        }

        do {
            let image = try await fetchImage(from: owner.avatarURL)
            await MainActor.run {
                self.setImage(to: self.imageView, image: image)
            }
        } catch {
            await MainActor.run {
                self.showErrorAlert()
            }
        }
    }
}
