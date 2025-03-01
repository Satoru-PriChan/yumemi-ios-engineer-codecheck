//
//  ComparisonModel.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/03/01.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import Foundation

struct ComparisonModel: Identifiable {
    let id = UUID()
    let repository: GithubRepositoryModel
    let similarityScore: Double
}
