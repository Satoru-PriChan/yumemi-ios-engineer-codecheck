//
//  DetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import Combine
import UIKit

struct DetailViewControllerFactory {
    private init() {}
    @MainActor
    static func create(viewModel: DetailViewModelProtocol) -> UIViewController {
        let vc = DetailViewController.instantiate()
        vc.setViewModel(viewModel: viewModel)
        return vc
    }
}

final class DetailViewController: UIViewController {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var languageLabel: UILabel!
    @IBOutlet private var starsLabel: UILabel!
    @IBOutlet private var watchersLabel: UILabel!
    @IBOutlet private var forksLabel: UILabel!
    @IBOutlet private var openIssuesLabel: UILabel!

    var viewModel: DetailViewModelProtocol?
    private var cancellables = Set<AnyCancellable>()

    func setViewModel(viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
        bindViewModel()
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await viewModel?.fetchAvatarImage()
        }
    }

    // MARK: - Private functions
    
    private func setUI() {
        titleLabel.accessibilityIdentifier = "TitleLabel"
        languageLabel.accessibilityIdentifier = "LanguageLabel"
        starsLabel.accessibilityIdentifier = "StarsLabel"
        watchersLabel.accessibilityIdentifier = "WatchersLabel"
        forksLabel.accessibilityIdentifier = "ForksLabel"
        openIssuesLabel.accessibilityIdentifier = "OpenIssuesLabel"
    }

    private func bindViewModel() {
        // リポジトリ情報の更新
        viewModel?.repositoryPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] model in
                self?.updateUI(with: model)
            }
            .store(in: &cancellables)

        // 画像の更新
        viewModel?.avatarImagePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] image in
                self?.imageView.image = image
            }
            .store(in: &cancellables)

        // エラーメッセージの監視
        viewModel?.errorMessagePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] errorMessage in
                if let errorMessage = errorMessage {
                    self?.showErrorAlert(message: errorMessage)
                }
            }
            .store(in: &cancellables)
    }

    private func updateUI(with repository: GithubRepositoryModel) {
        titleLabel.text = repository.fullName
        languageLabel.text = "Written in \(repository.language)"
        starsLabel.text = "\(repository.stargazersCount) stars"
        watchersLabel.text = "\(repository.watchersCount) watchers"
        forksLabel.text = "\(repository.forksCount) forks"
        openIssuesLabel.text = "\(repository.openIssuesCount) open issues"
    }
}

// MARK: - StoryboardInstantiatable

extension DetailViewController: StoryboardInstantiatable {}
