//
//  SearchListFooterView.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/02/27.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct SearchListFooterView: View {
    let onLoadMore: () -> Void

    var body: some View {
        GeometryReader { geometry in
            if geometry.frame(in: .global).maxY > 0 {
                // ビューが表示されたら次のページを読み込む
                Color.clear.onAppear {
                    onLoadMore()
                }
            } else {
                ProgressView() // ローディングインジケーター
            }
        }
        .frame(height: 50) // 適切な高さを設定
    }
}

#Preview {
    SearchListFooterView(onLoadMore: {})
}
