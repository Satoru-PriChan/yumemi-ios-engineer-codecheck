//
//  GradientButtonStyle.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/03/01.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import SwiftUI

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue, Color.purple]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(configuration.isPressed ? 0.1 : 0.3), radius: 5, x: 0, y: 5)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)// shrink on tap
            .animation(.easeOut, value: configuration.isPressed)
    }
}
