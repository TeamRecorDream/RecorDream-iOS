//
//  MainTabBarController.swift
//  PresentationTests
//
//  Created by Junho Lee on 2022/09/24.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_DSKit

import RxSwift
import RxRelay

public class MainTabBarController: RDTabBarController {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    public var factory: ViewControllerFactory!
    public var viewModel: MainTabBarViewModel!
    public var homeVC: HomeVC!
    public var storageVC: StorageVC!
    private let middleButtonTapped = PublishRelay<Void>()
    public var homeViewController: HomeVC!
    
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.setTabBar()
            self.setMiddleButtonAction()
            self.bindViewModels()
        }
    }
}

// MARK: - Methods

extension MainTabBarController {
    private func setTabBar() {
        let homeNVC = makeNavigationController(with: homeVC)
        let storageNVC = makeNavigationController(with: storageVC)
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
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func makeNavigationController(with vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.isNavigationBarHidden = true
        return nav
    }
    
    private func setMiddleButtonAction() {
        self.middleButtonAction = { [weak self] in
            guard let self = self else { return }
            let dreamWriteVC = self.factory.instantiateDreamWriteVC(.modify(postId: "63b47efa8030b7207e060b0d"))
            dreamWriteVC.modalPresentationStyle = .fullScreen
            self.present(dreamWriteVC, animated: true)
        }
    }
    
    private func bindViewModels() {
        let input = MainTabBarViewModel.Input(middleButtonTapped: middleButtonTapped.asObservable())
        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
    }
}
