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
    @IBOutlet private var starsCountLabel: UILabel!
    @IBOutlet private var watchersCountLabel: UILabel!
    @IBOutlet private var forksCountLabel: UILabel!
    @IBOutlet private var openIssuesCountLabel: UILabel!
    @IBOutlet private var starsImageView: UIImageView!
    @IBOutlet private var watchersImageView: UIImageView!
    @IBOutlet private var forksImageView: UIImageView!
    @IBOutlet private var openIssuesImageView: UIImageView!
    
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
        animateUI()
    }

    // MARK: - Private functions

    private func setUI() {
        // Back button color
        navigationController?.navigationBar.tintColor = R.color.textColor()
        view.backgroundColor = R.color.backgroundColor()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        titleLabel.accessibilityIdentifier = "DetailViewController_TitleLabel"
        languageLabel.accessibilityIdentifier = "DetailViewController_LanguageLabel"
        starsLabel.accessibilityIdentifier = "DetailViewController_StarsLabel"
        watchersLabel.accessibilityIdentifier = "DetailViewController_WatchersLabel"
        forksLabel.accessibilityIdentifier = "DetailViewController_ForksLabel"
        openIssuesLabel.accessibilityIdentifier = "DetailViewController_OpenIssuesLabel"
        titleLabel.textColor = R.color.textColor()
        languageLabel.textColor = R.color.textColor()
        starsLabel.textColor = R.color.textColor()
        watchersLabel.textColor = R.color.textColor()
        forksLabel.textColor = R.color.textColor()
        openIssuesLabel.textColor = R.color.textColor()
        titleLabel.font = .preferredFont(forTextStyle: .largeTitle)
        languageLabel.font = .preferredFont(forTextStyle: .body)
        starsLabel.font = .preferredFont(forTextStyle: .subheadline)
        watchersLabel.font = .preferredFont(forTextStyle: .subheadline)
        forksLabel.font = .preferredFont(forTextStyle: .subheadline)
        openIssuesLabel.font = .preferredFont(forTextStyle: .subheadline)
        starsCountLabel.textColor = R.color.textColor()
        watchersCountLabel.textColor = R.color.textColor()
        forksCountLabel.textColor = R.color.textColor()
        openIssuesCountLabel.textColor = R.color.textColor()
        starsImageView.image = UIImage(systemName: "star")
        watchersImageView.image = UIImage(systemName: "eye")
        forksImageView.image = UIImage(systemName: "tuningfork")
        openIssuesImageView.image = UIImage(systemName: "book.circle")
        starsImageView.tintColor = R.color.textColor()
        watchersImageView.tintColor = R.color.textColor()
        forksImageView.tintColor = R.color.textColor()
        openIssuesImageView.tintColor = R.color.textColor()
        prepareAnimation()
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
        starsCountLabel.text = "\(repository.stargazersCount)"
        watchersCountLabel.text = "\(repository.watchersCount)"
        forksCountLabel.text = "\(repository.forksCount)"
        openIssuesCountLabel.text = "\(repository.openIssuesCount)"
        updateCountFonts(with: repository)
        guard let imageURL = URL(string: repository.avatarURL) else {
            imageView.image = UIImage(named: "image-break")
            return
        }
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: imageURL)
    }
    
    private func updateCountFonts(with repository: GithubRepositoryModel) {
        if repository.stargazersCount > 100 {
            starsCountLabel.font = .systemFont(ofSize: 16, weight: .medium)
        } else if repository.stargazersCount > 1000 {
            starsCountLabel.font = .systemFont(ofSize: 17, weight: .heavy)
        } else if repository.stargazersCount > 10000 {
            starsCountLabel.font = .systemFont(ofSize: 18, weight: .bold)
        } else {
            starsCountLabel.font = .systemFont(ofSize: 14, weight: .light)
        }
        
        if repository.watchersCount > 100 {
            watchersCountLabel.font = .systemFont(ofSize: 16, weight: .medium)
        } else if repository.watchersCount > 1000 {
            watchersCountLabel.font = .systemFont(ofSize: 17, weight: .heavy)
        } else if repository.watchersCount > 10000 {
            watchersCountLabel.font = .systemFont(ofSize: 18, weight: .bold)
        } else {
            watchersCountLabel.font = .systemFont(ofSize: 14, weight: .light)
        }
        
        if repository.forksCount > 100 {
            forksCountLabel.font = .systemFont(ofSize: 16, weight: .medium)
        } else if repository.forksCount > 1000 {
            forksCountLabel.font = .systemFont(ofSize: 17, weight: .heavy)
        } else if repository.forksCount > 10000 {
            forksCountLabel.font = .systemFont(ofSize: 18, weight: .bold)
        } else {
            forksCountLabel.font = .systemFont(ofSize: 14, weight: .light)
        }
        
        openIssuesCountLabel.font = .systemFont(ofSize: 14, weight: .light)
    }
    
    private func prepareAnimation() {
        self.imageView.alpha = 0.1
        self.titleLabel.alpha = 0.1
        self.languageLabel.alpha = 0.1
        self.starsLabel.alpha = 0.1
        self.watchersLabel.alpha = 0.1
        self.forksLabel.alpha = 0.1
        self.openIssuesLabel.alpha = 0.1
    }
    
    private func animateUI() {
        UIView.animate(withDuration: 0.5, animations: {
            self.imageView.alpha = 1
        })
        UIView.animate(withDuration: 0.5, delay: 0.2, animations: {
            self.titleLabel.alpha = 1
            self.languageLabel.alpha = 1
            self.starsLabel.alpha = 1
            self.watchersLabel.alpha = 1
            self.forksLabel.alpha = 1
            self.openIssuesLabel.alpha = 1
        })
    }
}

// MARK: - StoryboardInstantiatable

extension DetailViewController: StoryboardInstantiatable {}
