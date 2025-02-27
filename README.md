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
- サードパーティーライブラリー
    - [nicklockwood/SwiftFormat](https://github.com/nicklockwood/SwiftFormat) 0.55.5
    - [onevcat/Kingfisher](https://github.com/onevcat/Kingfisher) 8.2.0
    - [mac-cain13/R.swift](https://github.com/mac-cain13/R.swift) 7.8.0

### 動作

1. 何かしらのキーワードを入力
2. GitHub API（`search/repositories`）でリポジトリーを検索し、結果一覧を概要（リポジトリ名）で表示
3. 特定の結果を選択したら、該当リポジトリの詳細（リポジトリ名、オーナーアイコン、プロジェクト言語、Star 数、Watcher 数、Fork 数、Issue 数）を表示

### リンティング

XcodeProject > 右クリック > SwiftFormatPlugin をクリックで、ソースコードが自動で綺麗に修正される。
<img width="1440" alt="截屏2025-02-25 15 52 09" src="https://github.com/user-attachments/assets/b487abd8-9ac8-4cdf-9ab4-ab8af7b2569f" />

## 課題取り組み

### [ソースコードの可読性の向上 #2](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/issues/2)

- [Feature/2 readability](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/12)
- [Feature/2 Update README](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/15)

一通り指示に対応した他、[nicklockwood/SwiftFormat](https://github.com/nicklockwood/SwiftFormat)を導入しさらにクリーンにしました。

### [ソースコードの安全性の向上 #3](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/issues/3)

- [Feature/3 improve code safety](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/14)
- [Feature/3 Introduce type-safety in GithubRepository](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/19/files)

面倒だったため以下のプロンプトでQWEN(AI)に直してもらった後、エラーアラートの実装、型安全は自分で追加しました。ネットワークを切断するとエラーアラートが動作することを確認しました。
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

### [バグを修正 #4](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/issues/4)
- [Feature/4 fix bugs ](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/16)
- A タイプミスによりAPIレスポンスのwatchers_countが使用されないというパースエラーを修正。
- B 垂直スタックビューのY位置を追加することで、詳細画面の画面が崩れていた点を修正
- C ScrollViewを使用し、詳細画面のタイトルラベルの制約を修正。タイトル文字列が長すぎる場合、タイトルラベルが画面に表示しきれていなかった。
- D `SearchViewController`の`DetailViewController`への参照にweakを追加し、メモリリーク防止コードを追加した。
    - XcodeのInstrumentsとMemory Inspectorではメモリリークの兆候は見られなかったので、何も発見できず。念のためメモリリーク防止コードを追加。
- [Bug: Prevent quick multiple taps4](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/24)
- クイックマルチタップを防ぐ
    - クイックマルチタップにより、複数のDetailViewControllerが表示されることがあった。

### [Fat VC の回避 #5](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/issues/5)
- [Feature/5 avoid fat vc](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/17)
- [Feature/5 Update README](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/18)
- Github リポジトリ APIコールをするactor `GithubRepository`を設け、APIコールの責務をViewController達から分離した。
- QWENで以下のプロンプトを入力しやってもらった。[Swift6関連でエラーが出ていたので、それは自分で修正した](https://qiita.com/satoru_pripara/items/df491bfd412f510927f8#non-sendable-type-string--any-returned-by-implicitly-asynchronous-call-to-actor-isolated-function-cannot-cross-actor-boundary)。

```
以下は二つのSwiftのファイルです。いずれもViewControllerクラスですが、中にサーバーのGithub API呼び出しコードが書かれています。API呼び出し部分はGithubRepositoryという新しいクラスに分離し、債務の切り分けをしたいのですが、可能でしょうか？: //
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
    private var searchWord: String?
    private var url: String?
    var fetchedRepositories: [[String: Any]] = []
    var selectedIndex: Int?
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "Detail" {
            guard let detailViewController = segue.destination as? DetailViewController else { return }
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
        guard let text = searchBar.text, !text.isEmpty else { return }
        searchWord = text
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(searchWord!)") else {
            fatalError("Github URL is invalid")
        }
        task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                Task { @MainActor in
                    self.showErrorAlert()
                }
                return
            }
            do {
                if let obj = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let items = obj["items"] as? [[String: Any]]
                {
                    Task { @MainActor in
                        self.fetchedRepositories = items
                        self.tableView.reloadData()
                    }
                } else {
                    Task { @MainActor in
                        self.showErrorAlert()
                    }
                }
            } catch {
                Task { @MainActor in
                    self.showErrorAlert()
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
        cell.textLabel?.text = repository["full_name"] as? String ?? "Unknown Repository"
        cell.detailTextLabel?.text = repository["language"] as? String ?? "Unknown Language"
        cell.tag = indexPath.row
        return cell
    }
    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
}
以下は、二つ目のファイルです: //
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
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let selectedIndex = searchViewController?.selectedIndex,
              searchViewController?.fetchedRepositories.indices.contains(selectedIndex) ?? false,
              let selectedRepository = searchViewController?.fetchedRepositories[selectedIndex] else { return }
        titleLabel.text = selectedRepository["full_name"] as? String ?? "Unknown Repository"
        languageLabel.text = "Written in \(selectedRepository["language"] as? String ?? "Unknown Language")"
        starsLabel.text = "\(selectedRepository["stargazers_count"] as? Int ?? 0) stars"
        watchersLabel.text = "\(selectedRepository["watchers_count"] as? Int ?? 0) watchers"
        forksLabel.text = "\(selectedRepository["forks_count"] as? Int ?? 0) forks"
        openIssuesLabel.text = "\(selectedRepository["open_issues_count"] as? Int ?? 0) open issues"
        fetchAndSetImage()
    }
    // MARK: - Private functions
    private func fetchAndSetImage() {
        guard let selectedIndex = searchViewController?.selectedIndex,
              searchViewController?.fetchedRepositories.indices.contains(selectedIndex) ?? false,
              let owner = searchViewController?.fetchedRepositories[selectedIndex]["owner"] as? [String: Any],
              let imgURLString = owner["avatar_url"] as? String,
              let imgURL = URL(string: imgURLString)
        else {
            showErrorAlert()
            return
        }
        URLSession.shared.dataTask(with: imgURL) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                Task { @MainActor in
                    self.showErrorAlert()
                }
                return
            }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }.resume()
    }
}
```

```
だいたいいいのですが、Swift6で書いております。GithubRepositoryをactorにしていただくことは可能ですか？
```

### [プログラム構造をリファクタリング #6](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/issues/6)
- [Feature/6 refactoring](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/20)
- DetailViewControllerにCQS原則を適用し、QueryとCommandを分けた
- DetailViewControllerのfetchAndSetImage関数に単一責任の原則を適用した
- プレースホルダを使用し、SearchBarの挙動について最小驚きの原則を適用した
    - 通常、SearchBarの注意事項を提示するなら、検索文字列として設定するのでなくプレースホルダーとして設定するので、その方が驚きが少ない

### [アーキテクチャを適用 #7](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/issues/7)
- [Feature/7 architecture](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/21)
- アーキテクチャ MVVM + Routerの適用
    - + クリーン・アーキテクチャで定義されたEntity＋Translatorを持つ。Entity(データ層で使う)とModel(UI層で使う)を分けないと、変更範囲が大きくなり脆弱になるため
- プロトコルを導入
- QWENに以下のプロンプトを入力し手伝ってもらった

```
以下のSwiftファイルからなるプロジェクトのアーキテクチャをMVVM+Routerに変えたいです。さらに、APIから取得してきたデータはEntity構造体として取得するが、UI層で使う前にModel構造体に変換して使うようにしたいです。変換するのはTranslatorと名のつくクラスなどにしたいです。以下はSwiftファイルです: //
//  GithubRepository.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/02/25.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//
import Foundation
import UIKit
/// Github repository API caller
/// Modifier `final` is allowed before actor https://forums.swift.org/t/why-can-you-constrain-to-final-classes-and-actors/65256/3
final actor GithubRepository {
    private let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }
    func searchRepositories(query: String) async throws -> [GithubRepositoryModel] {
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(query)") else {
            throw APIError.invalidURL
        }
        let (data, _) = try await session.data(from: url)
        let response = try JSONDecoder().decode(GithubRepositoryResponseModel.self, from: data)
        return response.items
    }
    func fetchImage(from urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        let (data, _) = try await session.data(from: url)
        guard let image = UIImage(data: data) else {
            throw APIError.invalidImageData
        }
        return image
    }
}
//
//  GithubRepositoryModel.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/02/26.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//
import Foundation
struct GithubRepositoryResponseModel: Codable, Sendable {
    let items: [GithubRepositoryModel]
}
struct GithubRepositoryModel: Codable, Sendable {
    let fullName: String
    let language: String?
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let owner: GithubOwnerModel
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case language
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case owner
    }
}
struct GithubOwnerModel: Codable, Sendable {
    let avatarURL: String
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
    }
}
enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidImageData
}
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
    private var searchWord: String?
    private var task: Task<Void, Never>?
    var fetchedRepositories: [GithubRepositoryModel] = []
    var selectedIndex: Int?
    private let githubRepository = GithubRepository()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "Detail" {
            guard let detailViewController = segue.destination as? DetailViewController else { return }
            detailViewController.searchViewController = self
        }
    }
}
// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange _: String) {
        task?.cancel()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        searchWord = text
        task = Task {
            do {
                let repositories = try await githubRepository.searchRepositories(query: text)
                await MainActor.run {
                    self.fetchedRepositories = repositories
                    self.tableView.reloadData()
                }
            } catch {
                await MainActor.run {
                    self.showErrorAlert()
                }
            }
        }
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
        cell.textLabel?.text = repository.fullName.isEmpty ? "Unknown Repository" : repository.fullName
        cell.detailTextLabel?.text = repository.language ?? "Unknown Language"
        cell.tag = indexPath.row
        return cell
    }
    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
}
//
//  ViewController+Alert.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/02/25.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//
import UIKit
extension UIViewController {
    func showErrorAlert(
        title: String = "エラー",
        message: String = "予期せぬエラーが発生しました",
        okAction: (() -> Void)? = nil
    ) {
        showAlert(title: title, message: message, okAction: okAction)
    }
    func showAlert(title: String, message: String, okAction: (() -> Void)? = nil) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            okAction?()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

```

```
ありがとうございます！ほぼ良いのですが、DetailViewControllerでエラーハンドリングを最初のように入れてくれませんか？
```

### [テストを追加 #10](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/issues/10)
- [Feature/7 architecture](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/21)
- [Clean: Silence warnings](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/23)
- トランスレータ、ビューモデルのユニットテストを追加
- UIテストの追加
    - SearchViewControllerからDetailViewControllerへ、そしてSearchViewControllerへ戻る回帰テスト
- テストカバレッジは87%

### [UI をブラッシュアップ #8](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/issues/8)
- [Feature/9 refine UI](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/25)
- [Clean: Update README about libraries](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/26)
- SearchViewControllerに画面全体の読み込みインジケータを追加
- DetailViewControllerの画像にKingFisherを導入する
- SearchViewControllerのタイトルを更新
- 戻るボタンのテキストを削除
- UIの色とフォントを更新
- DetailViewControllerの外観にアニメーションを追加
- スター、ウォッチャー、フォーク、openIssueの画像の追加とフォントの更新
- LanguageLabelを複数行にする
- ナビゲーションの戻るボタンの色を更新

|写真|写真|動画|
|:---:|:---:|:---:|
| ![Simulator Screenshot - iPhone SE 2nd iOS 18 3 - 2025-02-27 at 09 44 41](https://github.com/user-attachments/assets/a797f3e6-0536-489c-ad60-35c39f6ca4ae) | ![Simulator Screenshot - iPhone SE 2nd iOS 18 3 - 2025-02-27 at 09 44 46](https://github.com/user-attachments/assets/22912541-bec5-46e3-91a8-af2b9baa1abf) | https://github.com/user-attachments/assets/3bf0a107-9b48-404f-b866-4458b71986ca |

- [Feature/9 introduce swift UI](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/27)
- SwiftUIでUIKitをリプレース

|写真|写真|動画|
|:---:|:---:|:---:|
| ![Simulator Screenshot - iPhone 16 - 2025-02-27 at 13 45 53](https://github.com/user-attachments/assets/08ae60f1-7aa9-440f-8cf0-ee4da1c32571) |  ![Simulator Screenshot - iPhone 16 - 2025-02-27 at 13 45 58](https://github.com/user-attachments/assets/287f6dc3-c77c-4964-8919-a18c034b9e18) |  https://github.com/user-attachments/assets/4f0ef8a0-374b-461d-8c45-45191fee38b0 |

## 参考情報

提出された課題の評価ポイントについても詳しく書かれてありますので、ぜひご覧ください。

- [私が（iOS エンジニアの）採用でコードチェックする時何を見ているのか](https://qiita.com/lovee/items/d76c68341ec3e7beb611)
- [CocoaPods の利用手引き](https://qiita.com/ykws/items/b951a2e24ca85013e722)
- [ChatGPT (Model: GPT-4) でコードリファクタリングをやってみる](https://qiita.com/mitsuharu_e/items/213491c668ab75924cfd)

ChatGPTなどAIサービスの利用は禁止しておりません。  
利用にあたって工夫したプロンプトやソースコメント等をご提出頂くと加点評価する場合がございます。 (減点評価はありません)

## Attributes
[Icon by Amazona Adorada](https://www.freepik.com/icons/broken)