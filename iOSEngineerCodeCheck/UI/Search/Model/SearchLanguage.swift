//
//  SearchLanguage.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/02/28.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import SwiftUI

enum SearchLanguage: String, CaseIterable {
    case swift = "Swift"
    case javascript = "JavaScript"
    case python = "Python"
    case java = "Java"
    case ruby = "Ruby"
    case cpp = "C++"
    case go = "Go"
    case typescript = "TypeScript"
    case kotlin = "Kotlin"
    case php = "PHP"

    var color: Color {
        switch self {
        case .swift: return .blue
        case .javascript: return .yellow
        case .python: return .green
        case .java: return .orange
        case .ruby: return .red
        case .cpp: return .purple
        case .go: return .cyan
        case .typescript: return .indigo
        case .kotlin: return .pink
        case .php: return .brown
        }
    }
}
