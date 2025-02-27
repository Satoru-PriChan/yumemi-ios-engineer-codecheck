//
//  LoadingIndicator.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/02/26.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import UIKit

@MainActor
class LoadingIndicator {
    private static var window: UIWindow?
    private static var indicator: UIActivityIndicatorView?

    // インジケータを表示
    static func show() {
        guard window == nil else { return }

        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let newWindow = UIWindow(windowScene: windowScene!)
        newWindow.frame = UIScreen.main.bounds
        newWindow.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        newWindow.windowLevel = .alert + 1

        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()

        let rootViewController = UIViewController()
        rootViewController.view.backgroundColor = .clear
        rootViewController.view.addSubview(indicator)

        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: rootViewController.view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: rootViewController.view.centerYAnchor),
        ])

        newWindow.rootViewController = rootViewController
        newWindow.makeKeyAndVisible()

        window = newWindow
        self.indicator = indicator
    }

    // インジケータを非表示
    static func hide() {
        window?.isHidden = true
        window = nil
        indicator = nil
    }
}
