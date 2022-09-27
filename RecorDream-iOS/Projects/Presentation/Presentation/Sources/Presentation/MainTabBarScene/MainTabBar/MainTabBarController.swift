//
//  MainTabBarController.swift
//  PresentationTests
//
//  Created by Junho Lee on 2022/09/24.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_DSKit

public class MainTabBarController: RDTabBarController {
    
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.setTabBar()
            self.setMiddleButtonAction()
        }
    }
}

// MARK: - Methods

extension MainTabBarController {
    private func setTabBar() {
        let homeNVC = makeNavigationController(with: UIViewController())
        let storageNVC = makeNavigationController(with: UIViewController())
        homeNVC.view.backgroundColor = .gray
        storageNVC.view.backgroundColor = .cyan
        
        homeNVC.tabBarItem = UITabBarItem(title: "홈",
                                          image: RDDSKitAsset.Images.icnHome.image,
                                          selectedImage: RDDSKitAsset.Images.icnHome.image)
        storageNVC.tabBarItem = UITabBarItem(title: "보관함",
                                             image: RDDSKitAsset.Images.icnStorage.image,
                                             selectedImage: RDDSKitAsset.Images.icnStorage.image)
        
        setViewControllers([homeNVC, storageNVC], animated: false)
        
        if let items = self.tabBar.items {
            self.rdTabBar.add(items: items)
        }
        self.rdTabBar.tintColor = .white
    }
    
    private func makeNavigationController(with vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.isNavigationBarHidden = true
        return nav
    }
    
    private func setMiddleButtonAction() {
        self.middleButtonAction = {
            let vc = UIViewController()
            vc.view.backgroundColor = .blue
            self.present(vc, animated: true)
        }
    }
}
