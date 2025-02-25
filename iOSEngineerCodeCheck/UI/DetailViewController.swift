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
    
    private let githubRepository = GithubRepository() // actor インスタンス
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        Task {
            await fetchAndSetImage()
        }
    }
    
    // MARK: - Private functions
    
    private func configureView() {
        guard let selectedIndex = searchViewController?.selectedIndex,
              searchViewController?.fetchedRepositories.indices.contains(selectedIndex) ?? false,
              let selectedRepository = searchViewController?.fetchedRepositories[selectedIndex] else { return }

        titleLabel.text = selectedRepository["full_name"] as? String ?? "Unknown Repository"
        languageLabel.text = "Written in \(selectedRepository["language"] as? String ?? "Unknown Language")"
        starsLabel.text = "\(selectedRepository["stargazers_count"] as? Int ?? 0) stars"
        watchersLabel.text = "\(selectedRepository["watchers_count"] as? Int ?? 0) watchers"
        forksLabel.text = "\(selectedRepository["forks_count"] as? Int ?? 0) forks"
        openIssuesLabel.text = "\(selectedRepository["open_issues_count"] as? Int ?? 0) open issues"
    }
    
    private func fetchAndSetImage() async {
        guard let selectedIndex = searchViewController?.selectedIndex,
              searchViewController?.fetchedRepositories.indices.contains(selectedIndex) ?? false,
              let owner = searchViewController?.fetchedRepositories[selectedIndex]["owner"] as? [String: Any],
              let imgURLString = owner["avatar_url"] as? String
        else {
            await MainActor.run {
                self.showErrorAlert()
            }
            return
        }
        
        do {
            let image = try await githubRepository.fetchImage(from: imgURLString)
            await MainActor.run {
                self.imageView.image = image
            }
        } catch {
            await MainActor.run {
                self.showErrorAlert()
            }
        }
    }
}
