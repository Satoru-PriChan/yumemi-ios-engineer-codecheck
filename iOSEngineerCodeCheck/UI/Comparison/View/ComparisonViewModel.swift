//
//  ComparisonViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/03/01.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import Combine
import Foundation

@MainActor
protocol ComparisonViewModelProtocol: ObservableObject {
    var comparisonModels: [ComparisonModel] { get }
    var isLoading: Bool { get }
    var onError: ((String) -> Void)? { get set }
    init(
        repositoryModel: GithubRepositoryModel,
        githubRepository: GithubRepositoryProtocol,
        translator: GithubRepositoryTranslatorProtocol
    )
    func fetchSimilarRepositories() async throws
}

@MainActor
final class ComparisonViewModel: ComparisonViewModelProtocol {
    @Published var comparisonModels: [ComparisonModel] = []
    @Published var isLoading: Bool = false
    var onError: ((String) -> Void)?
    private let repositoryModel: GithubRepositoryModel
    private let githubRepository: GithubRepositoryProtocol
    private let translator: GithubRepositoryTranslatorProtocol

    init(
        repositoryModel: GithubRepositoryModel,
        githubRepository: GithubRepositoryProtocol,
        translator: GithubRepositoryTranslatorProtocol
    ) {
        self.repositoryModel = repositoryModel
        self.githubRepository = githubRepository
        self.translator = translator
    }

    func fetchSimilarRepositories() async throws {
        isLoading = true
        do {
            // TF-IDFベクトル化
            guard let queryVector = try? getTFIDFVector(text: repositoryModel.description ?? "") else { return }

            // リポジトリリスト
            let fetchedRepositories = try await githubRepository.searchRepositories(
                query: "\(repositoryModel.name) \(repositoryModel.language)",
                sort: SearchSortType.stars.rawValue,
                order: SearchOrderType.desc.rawValue,
                page: 1,
                perPage: 30
            )
            let allRepositories = translator.translate(
                from: fetchedRepositories
            ).items

            // 比較元と同じリポジトリを除外
            let filteredRepositories = allRepositories.filter { $0.repositoryID != repositoryModel.repositoryID }

            // 各リポジトリの類似度を計算
            var repositoriesWithScores: [(repository: GithubRepositoryModel, score: Double)] = []
            for targetRepo in filteredRepositories {
                if let targetVector = try? getTFIDFVector(text: targetRepo.description ?? "") {
                    let similarityScore = calculateCosineSimilarity(queryVector: queryVector, targetVector: targetVector)
                    repositoriesWithScores.append((repository: targetRepo, score: similarityScore))
                }
            }

            // 類似度順にソート
            let comparisonModels = repositoriesWithScores
                .sorted { $0.score > $1.score }
                .map { ComparisonModel(repository: $0.repository, similarityScore: $0.score) }
            self.comparisonModels = comparisonModels
        } catch {
            print("Error fetching similar repositories: \(error)")
            onError?("エラーが発生しました。")
        }
        isLoading = false
    }

    private func getTFIDFVector(text: String) throws -> [Double] {
        // 単語の頻度を計算
        let words = text.lowercased().components(separatedBy: CharacterSet.alphanumerics.inverted)
        var wordFrequency: [String: Int] = [:]
        for word in words {
            if !word.isEmpty {
                wordFrequency[word, default: 0] += 1
            }
        }

        // TF-IDFを計算（簡易版）
        var tfidfVector: [Double] = []
        let totalDocuments = 10 // 固定値（適当な数値）
        for word in wordFrequency.keys.sorted() {
            let tf = Double(wordFrequency[word]!) / Double(words.count)
            let idf = log(Double(totalDocuments) / (1 + 1)) // 1はドキュメント頻度（固定値）
            tfidfVector.append(tf * idf)
        }
        return tfidfVector
    }

    private func calculateCosineSimilarity(queryVector: [Double], targetVector: [Double]) -> Double {
        let dotProduct = zip(queryVector, targetVector).reduce(0) { $0 + $1.0 * $1.1 }
        let magnitude1 = sqrt(queryVector.reduce(0) { $0 + $1 * $1 })
        let magnitude2 = sqrt(targetVector.reduce(0) { $0 + $1 * $1 })
        return dotProduct / (magnitude1 * magnitude2)
    }
}
