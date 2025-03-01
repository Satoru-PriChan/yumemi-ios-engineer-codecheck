//
//  SearchSortType.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/02/27.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import Foundation

enum SearchSortType: String, CaseIterable, Hashable {
    case stars
    case forks
    case updated
}

enum SearchOrderType: String, CaseIterable, Hashable {
    case asc
    case desc
}

enum SearchPerPageType: Int, CaseIterable, Hashable {
    case ten = 10
    case thirty = 30
    case fifty = 50
    case hundred = 100
}
