//
//  DetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import Combine
import UIKit
import Kingfisher

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

    // MARK: - Private functions

    private func setUI() {
        titleLabel.accessibilityIdentifier = "DetailViewController_TitleLabel"
        languageLabel.accessibilityIdentifier = "DetailViewController_LanguageLabel"
        starsLabel.accessibilityIdentifier = "DetailViewController_StarsLabel"
        watchersLabel.accessibilityIdentifier = "DetailViewController_WatchersLabel"
        forksLabel.accessibilityIdentifier = "DetailViewController_ForksLabel"
        openIssuesLabel.accessibilityIdentifier = "DetailViewController_OpenIssuesLabel"
    }

    private func bindViewModel() {
        // リポジトリ情報の更新
        viewModel?.repositoryPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] model in
                self?.updateUI(with: model)
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
        guard let imageURL = URL(string: repository.avatarURL) else {
            imageView.image = UIImage(named: "image-break")
            return
        }
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: imageURL)
    }
}

// MARK: - StoryboardInstantiatable

extension DetailViewController: StoryboardInstantiatable {}
