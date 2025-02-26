//
//  SearchViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import Combine
import UIKit

struct SearchViewControllerFactory {
    private init() {}
    @MainActor
    static func create(viewModel: SearchViewModelProtocol) -> UIViewController {
        let vc = SearchViewController.instantiate()
        vc.setViewModel(viewModel: viewModel)
        return vc
    }
}

final class SearchViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet private var searchBar: UISearchBar!

    private var viewModel: SearchViewModelProtocol?
    private let router = AppRouter()
    private var cancellables = Set<AnyCancellable>()

    // MARK: - LifeCycle

    func setViewModel(viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
        bindViewModel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Make tap possible again
        tableView.isUserInteractionEnabled = true
    }

    // MARK: - Private function

    private func setUI() {
        searchBar.delegate = self
        searchBar.accessibilityIdentifier = "SearchViewController_SearchBar"
        title = "Github Repositories"
    }

    private func bindViewModel() {
        viewModel?.repositoriesPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)

        viewModel?.errorMessagePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] message in
                if let message = message {
                    self?.showErrorAlert(message: message)
                }
            }
            .store(in: &cancellables)

        viewModel?.isLoadingPublisher
            .receive(on: RunLoop.main)
            .sink { isLoading in
                if isLoading {
                    LoadingIndicator.show()
                } else {
                    LoadingIndicator.hide()
                }
            }
            .store(in: &cancellables)
    }

    // MARK: - UITableViewDataSource

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return viewModel?.repositories.count ?? 0
    }

    override func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        guard let repository = viewModel?.repositories[indexPath.row] else {
            return cell
        }
        cell.textLabel?.text = repository.fullName
        return cell
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Prevent quick multiple tap
        tableView.isUserInteractionEnabled = false
        guard let repository = viewModel?.repositories[indexPath.row] else {
            showErrorAlert()
            return
        }
        router.showDetail(from: self, repository: repository)
    }

    // MARK: - UISearchBarDelegate

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        Task {
            await viewModel?.searchRepositories(query: text)
        }
    }
}

// MARK: - StoryboardInstantiatable

extension SearchViewController: StoryboardInstantiatable {}
