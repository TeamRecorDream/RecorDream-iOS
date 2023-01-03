//
//  DependencyContainer+PushNoticeCoordinatable.swift
//  RD-Navigator
//
//  Created by Junho Lee on 2022/12/30.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

import UIKit

import RD_Core

import Presentation

extension DependencyContainer: PushNoticeCoordinatable {
    public func coordinateDreamWriteVC(currentVC: UIViewController? = nil) {
        var topVC = currentVC
        if topVC == nil {
            topVC = UIApplication.getMostTopViewController()
        }
        
        if topVC is DreamWriteVC {
            return
        }
        
        let navigation = topVC as? UINavigationController
        let tabBarController = navigation?.viewControllers.first
        if topVC is HomeVC || topVC is StorageVC || tabBarController is MainTabBarController {
            let dreamWriteVC = self.instantiateDreamWriteVC(.write)
            dreamWriteVC.modalPresentationStyle = .fullScreen
            UIApplication.getMostTopViewController()?.present(dreamWriteVC,
                           animated: true)
            return
        }
        
        if let presentingViewController = topVC?.presentingViewController {
            topVC?.dismiss(animated: true) {
                self.coordinateDreamWriteVC(currentVC: presentingViewController)
            }
        } else if let navigationController = topVC?.navigationController {
            UIView.animate(withDuration: 0, animations: {
                navigationController.popToRootViewController(animated: true)
            }) { _ in
                self.coordinateDreamWriteVC(currentVC: navigationController.topViewController)
            }
        }
    }
}
