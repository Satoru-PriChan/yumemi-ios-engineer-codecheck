//
//  SearchViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import Combine

final class SearchViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet private weak var searchBar: UISearchBar!

    private var viewModel: SearchViewModelProtocol = SearchViewModel()
    private let router = AppRouter()
    private var cancellables = Set<AnyCancellable>()

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        searchBar.delegate = self
    }
    
    // MARK: - Private function

    private func bindViewModel() {
        viewModel.repositoriesPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)

        viewModel.errorMessagePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] message in
                if let message = message {
                    self?.showErrorAlert(message: message)
                }
            }
            .store(in: &cancellables)
    }

    // MARK: - UITableViewDataSource
    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return viewModel.repositories.count
    }

    override func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let repository = viewModel.repositories[indexPath.row]
        cell.textLabel?.text = repository.fullName
        return cell
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository = viewModel.repositories[indexPath.row]
        router.showDetail(from: self, repository: repository)
    }

    // MARK: - UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        Task {
            await viewModel.searchRepositories(query: text)
        }
    }
}
