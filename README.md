# 株式会社ゆめみ iOS エンジニアコードチェック課題

## 概要

本プロジェクトは株式会社ゆめみ（以下弊社）が、弊社に iOS エンジニアを希望する方に出す課題のベースプロジェクトです。本課題が与えられた方は、下記の説明を詳しく読んだ上で課題を取り組んでください。

新卒／未経験者エンジニアの場合、本リファクタリングの通常課題の代わりに、[新規アプリ作成の特別課題](https://yumemi-ios-junior-engineer-codecheck.app.swift.cloud)も選択できますので、ご自身が得意と感じる方を選んでください。特別課題を選んだ場合、通常課題の取り組みは不要です。新規アプリ作成の課題の説明を詳しく読んだ上で課題を取り組んでください。

## アプリ仕様

本アプリは GitHub のリポジトリーを検索するアプリです。

![動作イメージ](README_Images/app.gif)

### 環境

- IDE：基本最新の安定版（本概要更新時点では Xcode 15.2）
- Swift：基本最新の安定版（本概要更新時点では Swift 5.9）
- 開発ターゲット：基本最新の安定版（本概要更新時点では iOS 17.2）
- サードパーティーライブラリーの利用：オープンソースのものに限り制限しない

### 動作

1. 何かしらのキーワードを入力
2. GitHub API（`search/repositories`）でリポジトリーを検索し、結果一覧を概要（リポジトリ名）で表示
3. 特定の結果を選択したら、該当リポジトリの詳細（リポジトリ名、オーナーアイコン、プロジェクト言語、Star 数、Watcher 数、Fork 数、Issue 数）を表示

## 課題取り組み

### [ソースコードの安全性の向上 #3](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/issues/3)

- [Feature/3 improve code safety](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/14)

面倒だったため以下のプロンプトでQWEN(AI)に直してもらった後、エラーアラートの実装は自分で追加しました。ネットワークを切断するとエラーアラートが動作することを確認しました。
渡しているコードはゆめみ様の公開リポジトリのコードですから、AIに渡しても問題ないと判断しました。その後、SwiftFormatによりフォーマットを綺麗にしました。

プロンプト: 
```
以下のSwiftファイルには安全性の低いコードたくさんあります。下記のリストを参考に、安全性の低いコードを撲滅し、安全性を高めましょう。ただし以下の観点以外の修正はしないでください。1.強制アンラップ
2. 強制ダウンキャスト
3.不必要なIUO
4.想定外の nil の握り潰し Swiftファイルは以下の二つです。SearchViewController: //
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
最後のファイルです。DetailViewController: //
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
    var searchViewController: SearchViewController!
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let selectedRepository = searchViewController.fetchedRepositories[searchViewController.selectedIndex]
        languageLabel.text = "Written in \(selectedRepository["language"] as? String ?? "")"
        starsLabel.text = "\(selectedRepository["stargazers_count"] as? Int ?? 0) stars"
        watchersLabel.text = "\(selectedRepository["wachers_count"] as? Int ?? 0) watchers"
        forksLabel.text = "\(selectedRepository["forks_count"] as? Int ?? 0) forks"
        openIssuesLabel.text = "\(selectedRepository["open_issues_count"] as? Int ?? 0) open issues"
        fetchAndSetImage()
    }
    // MARK: - Private functions
    private func fetchAndSetImage() {
        let selectedRepository = searchViewController.fetchedRepositories[searchViewController.selectedIndex]
        titleLabel.text = selectedRepository["full_name"] as? String
        if let owner = selectedRepository["owner"] as? [String: Any],
           let imgURL = owner["avatar_url"] as? String
        {
            URLSession.shared.dataTask(with: URL(string: imgURL)!) { data, _, _ in
                let image = UIImage(data: data!)!
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }.resume()
        }
    }
}
```


## 参考情報

提出された課題の評価ポイントについても詳しく書かれてありますので、ぜひご覧ください。

- [私が（iOS エンジニアの）採用でコードチェックする時何を見ているのか](https://qiita.com/lovee/items/d76c68341ec3e7beb611)
- [CocoaPods の利用手引き](https://qiita.com/ykws/items/b951a2e24ca85013e722)
- [ChatGPT (Model: GPT-4) でコードリファクタリングをやってみる](https://qiita.com/mitsuharu_e/items/213491c668ab75924cfd)

ChatGPTなどAIサービスの利用は禁止しておりません。  
利用にあたって工夫したプロンプトやソースコメント等をご提出頂くと加点評価する場合がございます。 (減点評価はありません)
