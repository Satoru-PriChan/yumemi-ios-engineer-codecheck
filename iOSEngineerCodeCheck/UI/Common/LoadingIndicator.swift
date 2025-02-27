//
//  LoadingIndicator.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/02/26.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct LoadingIndicator: View {
    @Binding var isShowing: Bool

    var body: some View {
        ZStack {
            if isShowing {
                Color.black.opacity(0.5) // Background dimming
                    .edgesIgnoringSafeArea(.all)

                ProgressView() // SwiftUI's equivalent of UIActivityIndicatorView
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2) // Increase size for visibility
            }
        }
    }
}

// MARK: - View Modifier for Easy Integration

struct LoadingIndicatorModifier: ViewModifier {
    @Binding var isShowing: Bool

    func body(content: Content) -> some View {
        ZStack {
            content
            if isShowing {
                LoadingIndicator(isShowing: $isShowing)
            }
        }
    }
}

extension View {
    func loadingIndicator(isShowing: Binding<Bool>) -> some View {
        modifier(LoadingIndicatorModifier(isShowing: isShowing))
    }
}
