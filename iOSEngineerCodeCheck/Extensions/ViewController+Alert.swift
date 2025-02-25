//
//  ViewController+Alert.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/02/25.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import UIKit

extension UIViewController {
    func showErrorAlert(
        title: String = "エラー",
        message: String = "予期せぬエラーが発生しました",
        okAction: (() -> Void)? = nil
    ) {
        showAlert(title: title, message: message, okAction: okAction)
    }

    func showAlert(title: String, message: String, okAction: (() -> Void)? = nil) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            okAction?()
        }
        alert.addAction(okAction)

        present(alert, animated: true, completion: nil)
    }
}
