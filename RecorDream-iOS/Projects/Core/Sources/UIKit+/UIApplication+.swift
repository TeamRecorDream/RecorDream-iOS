//
//  UIApplication+.swift
//  RD-Core
//
//  Created by Junho Lee on 2022/10/12.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

public extension UIApplication {
    static var topRootViewController: UIViewController? {
        UIWindow.keyWindowGetter?.rootViewController
    }
    
    class func getMostTopViewController(base: UIViewController? = nil) -> UIViewController? {
        
        var baseVC: UIViewController?
        if base != nil {
            baseVC = base
        }
        else {
            baseVC = (UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow })?.rootViewController
        }
        
        if let naviController = baseVC as? UINavigationController {
            return getMostTopViewController(base: naviController.visibleViewController)
            
        } else if let tabbarController = baseVC as? UITabBarController, let selected = tabbarController.selectedViewController {
            return getMostTopViewController(base: selected)
            
        } else if let presented = baseVC?.presentedViewController {
            return getMostTopViewController(base: presented)
        }
        return baseVC
    }
    
    static func setRootViewController(window: UIWindow, viewController: UIViewController, withAnimation: Bool) {
        if !withAnimation {
            window.rootViewController = viewController
            window.makeKeyAndVisible()
            return
        }

        if let snapshot = window.snapshotView(afterScreenUpdates: true) {
            viewController.view.addSubview(snapshot)
            window.rootViewController = viewController
            window.makeKeyAndVisible()
            
            UIView.animate(withDuration: 0.4, animations: {
                snapshot.layer.opacity = 0
            }, completion: { _ in
                snapshot.removeFromSuperview()
            })
        }
    }
}

