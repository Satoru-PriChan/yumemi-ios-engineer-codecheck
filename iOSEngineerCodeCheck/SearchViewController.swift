//
//  SearchViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class SearchViewController: UITableViewController {
    // MARK: - Properties

    @IBOutlet private var searchBar: UISearchBar!

    private var task: URLSessionTask?
    private var searchWord: String!
    private var url: String!

    var fetchedRepositories: [[String: Any]] = []
    var selectedIndex: Int!

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }

    // MARK: - Segue

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "Detail" {
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.searchViewController = self
        }
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // 初期のテキスト削除
        searchBar.text = ""
        return true
    }

    func searchBar(_: UISearchBar, textDidChange _: String) {
        task?.cancel()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchWord = searchBar.text!

        guard searchWord.count != 0 else { return }

        url = "https://api.github.com/search/repositories?q=\(searchWord!)"
        task = URLSession.shared.dataTask(
            with: URL(
                string: url
            )!
        ) { data, _, _ in
            if let obj = try! JSONSerialization.jsonObject(with: data!) as? [String: Any],
               let items = obj["items"] as? [[String: Any]]
            {
                Task { @MainActor in
                    self.fetchedRepositories = items
                    self.tableView.reloadData()
                }
            }
        }
        task?.resume()
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController {
    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return fetchedRepositories.count
    }

    override func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let repository = fetchedRepositories[indexPath.row]
        cell.textLabel?.text = repository["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = repository["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
}
