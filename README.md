# 株式会社ゆめみ iOS エンジニアコードチェック課題 山崎謙登

## 概要
本プロジェクトは株式会社ゆめみ様がiOSエンジニア向けに出された課題の回答です。

## 回答者
山崎謙登

## アプリ仕様
本アプリは GitHub のリポジトリーを検索するアプリです。

- 動作イメージ: https://drive.google.com/file/d/1xDKs4NaMrrMqWlbgLV9S4kiWUXIS6DOy/view?usp=sharing

### 環境

- IDE: 2025/2/5(火)時点での安定版（Xcode16.2）
- Swift：2025/2/5(火)時点での安定版（Swift 6.0.3）
- 開発ターゲット：2025/2/5(火)時点での安定版（iOS 18.0）
- サードパーティーライブラリー
    - [nicklockwood/SwiftFormat](https://github.com/nicklockwood/SwiftFormat) 0.55.5
    - [onevcat/Kingfisher](https://github.com/onevcat/Kingfisher) 8.2.0
    - [mac-cain13/R.swift](https://github.com/mac-cain13/R.swift) 7.8.0

### 動作

1. 何かしらのキーワードを入力, 必要なら画面右上の検索条件ボタンをタップし検索条件を設定
2. GitHub API（`search/repositories`）でリポジトリーを検索し、結果一覧を概要（リポジトリ名）で表示
3. 特定の結果を選択したら、該当リポジトリの詳細（リポジトリ名、オーナーアイコン、プロジェクト言語、Star 数、Watcher 数、Fork 数、Issue 数）を表示

### リンティング

XcodeProject > 右クリック > SwiftFormatPlugin をクリックで、ソースコードが自動で綺麗に修正される。
<img width="1440" alt="截屏2025-02-25 15 52 09" src="https://github.com/user-attachments/assets/b487abd8-9ac8-4cdf-9ab4-ab8af7b2569f" />

## 課題取り組み

- [全課題終了後の最終成果コード develop -> main](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/30)

### [ソースコードの可読性の向上 #2](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/issues/2)

- [Feature/2 readability](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/12)
- [Feature/2 Update README](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/15)

一通り指示に対応した他、[nicklockwood/SwiftFormat](https://github.com/nicklockwood/SwiftFormat)を導入しさらにクリーンにした。

### [ソースコードの安全性の向上 #3](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/issues/3)

#### 概要
- [Feature/3 improve code safety](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/14)
- [Feature/3 Introduce type-safety in GithubRepository](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/19/files)

- 安全性を向上した。エラーアラートの実装、型安全も実装した。ネットワークを切断するとエラーアラートが動作することを確認した。

#### プロンプト
```
以下のSwiftファイルには安全性の低いコードたくさんあります。下記のリストを参考に、安全性の低いコードを撲滅し、安全性を高めましょう。ただし以下の観点以外の修正はしないでください。1.強制アンラップ
2. 強制ダウンキャスト
3.不必要なIUO
4.想定外の nil の握り潰し Swiftファイルは以下の二つです。
```

### [バグを修正 #4](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/issues/4)

#### 概要
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

#### 概要
- [Feature/5 avoid fat vc](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/17)
- [Feature/5 Update README](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/18)
- Github リポジトリ APIコールをするactor `GithubRepository`を設け、APIコールの責務をViewController達から分離した。
- [Swift6関連でエラーが出ていたので、修正した](https://qiita.com/satoru_pripara/items/df491bfd412f510927f8#non-sendable-type-string--any-returned-by-implicitly-asynchronous-call-to-actor-isolated-function-cannot-cross-actor-boundary)。

#### プロンプト
```
以下は二つのSwiftのファイルです。いずれもViewControllerクラスですが、中にサーバーのGithub API呼び出しコードが書かれています。API呼び出し部分はGithubRepositoryという新しいクラスに分離し、債務の切り分けをしたいのですが、可能でしょうか？: //
```

```
だいたいいいのですが、Swift6で書いております。GithubRepositoryをactorにしていただくことは可能ですか？
```

### [プログラム構造をリファクタリング #6](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/issues/6)

#### 概要
- [Feature/6 refactoring](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/20)
- DetailViewControllerにCQS原則を適用し、QueryとCommandを分けた
- DetailViewControllerのfetchAndSetImage関数に単一責任の原則を適用した
- プレースホルダを使用し、SearchBarの挙動について最小驚きの原則を適用した
    - 通常、SearchBarの注意事項を提示するなら、検索文字列として設定するのでなくプレースホルダーとして設定するので、その方が驚きが少ない

### [アーキテクチャを適用 #7](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/issues/7)

#### 概要
- [Feature/7 architecture](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/21)
- アーキテクチャ MVVM + Routerの適用
    - + クリーン・アーキテクチャで定義されたEntity＋Translatorを持つ。Entity(データ層で使う)とModel(UI層で使う)を分けないと、変更範囲が大きくなり脆弱になるため
- プロトコルを導入

#### プロンプト
```
以下のSwiftファイルからなるプロジェクトのアーキテクチャをMVVM+Routerに変えたいです。さらに、APIから取得してきたデータはEntity構造体として取得するが、UI層で使う前にModel構造体に変換して使うようにしたいです。変換するのはTranslatorと名のつくクラスなどにしたいです。以下はSwiftファイルです:
```

```
ありがとうございます！ほぼ良いのですが、DetailViewControllerでエラーハンドリングを最初のように入れてくれませんか？
```

### [テストを追加 #10](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/issues/10)

#### 概要
- [Feature/7 architecture](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/21)
- [Clean: Silence warnings](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/23)
- トランスレータ、ビューモデルのユニットテストを追加
- UIテストの追加
    - SearchViewControllerからDetailViewControllerへ、そしてSearchViewControllerへ戻る回帰テスト
- テストカバレッジは87%

### [UI をブラッシュアップ #8](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/issues/8)

#### 概要
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

#### プロンプト

```
以下のような検索画面と詳細画面からなるSwift言語によるiOSアプリがあるのですが。デザインを理知的なクールな洗練された感じにしたいと考えています。何かアイディアはありますか
```

#### 写真
|写真|写真|動画|
|:---:|:---:|:---:|
| ![Simulator Screenshot - iPhone SE 2nd iOS 18 3 - 2025-02-27 at 09 44 41](https://github.com/user-attachments/assets/a797f3e6-0536-489c-ad60-35c39f6ca4ae) | ![Simulator Screenshot - iPhone SE 2nd iOS 18 3 - 2025-02-27 at 09 44 46](https://github.com/user-attachments/assets/22912541-bec5-46e3-91a8-af2b9baa1abf) | https://github.com/user-attachments/assets/3bf0a107-9b48-404f-b866-4458b71986ca |

#### 概要 - 2
- [Feature/9 introduce swift UI](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/27)
- SwiftUIでUIKitをリプレース
- プロンプト: `Convert to SwiftUI:`

#### 写真 - 2
|写真|写真|動画|
|:---:|:---:|:---:|
| ![Simulator Screenshot - iPhone 16 - 2025-02-27 at 13 45 53](https://github.com/user-attachments/assets/08ae60f1-7aa9-440f-8cf0-ee4da1c32571) |  ![Simulator Screenshot - iPhone 16 - 2025-02-27 at 13 45 58](https://github.com/user-attachments/assets/287f6dc3-c77c-4964-8919-a18c034b9e18) |  https://github.com/user-attachments/assets/4f0ef8a0-374b-461d-8c45-45191fee38b0 |

### [新機能追加 #9](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/issues/9)

#### 概要
[Feature/9 add new features](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/28)
- DetailViewを更新してすべてのAPIレスポンスを表示する
    - すべての情報をクリップボードにコピーできる
    - URLをタップしてSafariにジャンプできる
- SearchViewを更新し、検索数の合計を表示
- 検索条件ボタンを追加し、検索条件のモーダルビューを表示
- 全ての検索条件を設定可能(星、フォーク、更新、Asc、Desc、ページ単位)
- SearchViewにページネーション機能を追加
- SeachViewの各行に言語情報と説明を追加

[Feature/9 new feature similar repositories comparison](https://github.com/Satoru-PriChan/yumemi-ios-engineer-codecheck/pull/31)
- 比較ビューを追加し、リポジトリを他の類似リポジトリと類似スコアで比較できるようになりました。

#### プロンプト
- `以下のSwiftファイルの検索画面に、Githubリポジトリのタイトルとスター数が表示されています。しかし、これに加えて、言語、詳細情報（一行のみ）も表示したいのですが、可能でしょうか？GithubRepositoryModelのlanguage、descriptionにそれら情報が入っています。`
- `最高です！一点だけ、言語の欄の色のついた丸がありますが、この色って言語ごとに変えられたりしますか？`
- `最高です！型安全のため、辞書型ではなく、専用のenumを定義してやることはできますか？`
- `Github API search/repository を利用してGithub Repositoryを検索するアプリを作成しました。選択したある一つのリポジトリの詳細画面で、相互比較ボタンを押すと、似たようなGithub上のリポジトリを自動でピックアップし、相互の比較や実装例をみれる画面を出す機能を追加したいです。AIを使ってもいいです。以下と添付ファイルに既存のソースコードを貼りました。`

## 写真

|||||||
|:---:|:---:|:---:|:---:|:---:|:---:|
|   ![Simulator Screenshot - iPhone SE 2nd iOS 18 3 - 2025-03-01 at 21 19 46](https://github.com/user-attachments/assets/f192fe94-166a-4e8d-9a53-88bb651b0ecc) |   ![Simulator Screenshot - iPhone SE 2nd iOS 18 3 - 2025-03-01 at 21 19 56](https://github.com/user-attachments/assets/10342d67-138a-4c86-bfb5-fb089d82dace) |   ![Simulator Screenshot - iPhone SE 2nd iOS 18 3 - 2025-03-01 at 21 20 10](https://github.com/user-attachments/assets/9a1a7300-feac-4937-84dc-885790c2e5a1) | ![Simulator Screenshot - iPhone SE 2nd iOS 18 3 - 2025-03-01 at 21 20 17](https://github.com/user-attachments/assets/7d0ceedd-e549-4c52-b429-52f776f496f8)  |  ![Simulator Screenshot - iPhone SE 2nd iOS 18 3 - 2025-03-01 at 21 20 25](https://github.com/user-attachments/assets/9ceb1fe2-41c6-4d57-bd95-55a4d16d6760) | ![Simulator Screenshot - iPhone SE 2nd iOS 18 3 - 2025-03-01 at 21 21 03](https://github.com/user-attachments/assets/2210e67c-fb40-44d7-9230-c81918f347f6) |

## 動画
- https://drive.google.com/file/d/1JlfqHjNYKoGGMEBjzvL-BS_34FYIiDe8/view?usp=sharing

## Attributes
[Icon by Amazona Adorada](https://www.freepik.com/icons/broken)