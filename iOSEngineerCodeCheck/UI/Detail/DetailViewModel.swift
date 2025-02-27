//
//  DetailViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/02/26.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//
import Combine

@MainActor
protocol DetailViewModelProtocol: ObservableObject {
    var repository: GithubRepositoryModel { get }
}

@MainActor
final class DetailViewModel: DetailViewModelProtocol {
    @Published var repository: GithubRepositoryModel
    
    init(repository: GithubRepositoryModel) {
        self.repository = repository
    }
}
