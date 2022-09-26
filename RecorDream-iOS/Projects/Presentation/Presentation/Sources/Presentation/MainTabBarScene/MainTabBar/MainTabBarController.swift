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
        }
    }
}

// MARK: - Methods

extension MainTabBarController {
    private func setTabBar() {
        let homeVC = UIViewController()
        homeVC.view.backgroundColor = .gray
        let storageVC = UIViewController()
        storageVC.view.backgroundColor = .cyan
        let plusVC = UIViewController()
        plusVC.view.backgroundColor = .red
        
        let homeNVC = UINavigationController(rootViewController: homeVC)
        homeNVC.isNavigationBarHidden = true
        homeNVC.view.backgroundColor = .gray
        
        let storageNVC = UINavigationController(rootViewController: storageVC)
        storageNVC.isNavigationBarHidden = true
        storageNVC.view.backgroundColor = .cyan
        
        homeNVC.tabBarItem = UITabBarItem(title: "홈", image: RDDSKitAsset.Images.icnHome.image, selectedImage: RDDSKitAsset.Images.icnHome.image)
        storageNVC.tabBarItem = UITabBarItem(title: "보관함", image: RDDSKitAsset.Images.icnStorage.image, selectedImage: RDDSKitAsset.Images.icnStorage.image)
        
        setViewControllers([homeNVC, plusVC, storageNVC], animated: false)
        
        // set customTabBar.
        if let items = self.tabBar.items {
            self.rdTabBar.add(items: items)
        }
        self.rdTabBar.tintColor = .white
        
        self.selectedIndex = 1
    }
}


