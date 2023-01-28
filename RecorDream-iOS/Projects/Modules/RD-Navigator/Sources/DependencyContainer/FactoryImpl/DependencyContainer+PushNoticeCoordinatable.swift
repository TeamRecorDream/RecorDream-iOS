//
//  DependencyContainer+PushNoticeCoordinatable.swift
//  RD-Navigator
//
//  Created by Junho Lee on 2022/12/30.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

import UIKit

import RD_Core
import RD_Logger

import Presentation

extension DependencyContainer: PushNoticeCoordinatable {
    public func coordinateDreamWriteVC(currentVC: UIViewController? = nil) {
        var topVC = currentVC
        if topVC == nil {
            topVC = UIApplication.getMostTopViewController()
        }
        
        if let dreamWriteVC = topVC as? DreamWriteVC {
            dreamWriteVC.viewModel.fromPushNotice = true
            AnalyticsManager.log(event: .clickPushNotice)
            return
        }
        
        let navigation = topVC as? UINavigationController
        let tabBarController = navigation?.viewControllers.first
        if topVC is HomeVC || topVC is StorageVC || tabBarController is MainTabBarController {
            let dreamWriteVC = self.instantiateDreamWriteVCFromPush(.write)
            dreamWriteVC.modalPresentationStyle = .fullScreen
            UIApplication.getMostTopViewController()?.present(dreamWriteVC,
                           animated: true)
            AnalyticsManager.log(event: .clickPushNotice)
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
