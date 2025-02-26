//
//  StoryboardInstantiatable.swift
//  iOSEngineerCodeCheck
//
//  Created by kento.yamazaki on 2025/02/26.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import UIKit

public protocol StoryboardInstantiatable {
    static var storyboardName: String { get }
    static var viewControllerIdentifier: String? { get }
    static var bundle: Bundle? { get }
}

public extension StoryboardInstantiatable where Self: UIViewController {
    static var storyboardName: String {
        return String(describing: self)
    }
    
    static var viewControllerIdentifier: String? {
        return nil
    }
    
    static var bundle: Bundle? {
        return nil
    }
    
    @MainActor
    static func instantiate() -> Self {
        let loadViewController = { () -> UIViewController? in
            let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
            if let viewControllerIdentifier = viewControllerIdentifier {
                return storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier)
            } else {
                return storyboard.instantiateInitialViewController()
            }
        }
        
        guard let viewController = loadViewController() as? Self else {
            fatalError("Cannot instantiate \(self)")
        }
        return viewController
    }
}
