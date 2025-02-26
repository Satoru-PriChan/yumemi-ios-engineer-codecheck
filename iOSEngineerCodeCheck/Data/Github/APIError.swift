//
//  APIError.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/02/26.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidImageData
}
