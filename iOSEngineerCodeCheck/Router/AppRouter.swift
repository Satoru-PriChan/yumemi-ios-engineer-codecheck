//
//  AppRouter.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/02/26.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import UIKit

protocol AppRouterProtocol {
    @MainActor
    func showDetail(from viewController: UIViewController, repository: GithubRepositoryModel)
}

final class AppRouter: AppRouterProtocol {
    @MainActor
    func showDetail(from viewController: UIViewController, repository: GithubRepositoryModel) {
        let detailViewController = DetailViewControllerFactory.create(viewModel: DetailViewModel(repository: repository))
        viewController.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
