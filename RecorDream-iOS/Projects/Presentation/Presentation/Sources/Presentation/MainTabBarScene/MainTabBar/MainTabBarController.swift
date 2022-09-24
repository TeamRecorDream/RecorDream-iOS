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
        let feedVC = UIViewController()
        feedVC.view.backgroundColor = .gray
        let homeVC = UIViewController()
        homeVC.view.backgroundColor = .cyan
        let plusVC = UIViewController()
        plusVC.view.backgroundColor = .red
        
        feedVC.tabBarItem = UITabBarItem(title: "피드", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        homeVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "circle"), selectedImage: UIImage(systemName: "circle.fill"))
        
        let feedNVC = UINavigationController(rootViewController: feedVC)
        feedNVC.isNavigationBarHidden = true
        feedNVC.view.backgroundColor = .gray
        
        let homeNVC = UINavigationController(rootViewController: homeVC)
        homeNVC.isNavigationBarHidden = true
        homeNVC.view.backgroundColor = .cyan
        
        setViewControllers([feedNVC, plusVC, homeNVC], animated: false)
        
        // set customTabBar.
        if let items = self.tabBar.items {
            self.rdTabBar.add(items: items)
        }
        self.rdTabBar.tintColor = .blue
        
        self.selectedIndex = 1
    }
}


