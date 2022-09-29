//
//  WalktroughCoordinator.swift
//  RouterCoordinator
//
//  Created by Junho Lee on 2022/09/29.
//

import Foundation

import Presentation

final class MainTabBarCoordinator: BaseCoordinator, CoordinatorFinishOutput {
    
    // MARK: - CoordinatorFinishOutput
    
    var finishFlow: (() -> Void)?
    
    // MARK: - Vars & Lets
    
    private let router: RouterProtocol
    private let factory: Factory
    
    // MARK: - Private metods
    
    private func showHomeViewController() {
        let MainTabBarController = self.factory.instantiateMainTabBarController()
        MainTabBarController.onFinishWalktrough = { [unowned self] in
            if $0 {
                self.router.popModule()
            }
            self.finishFlow?()
        }
        self.router.push(MainTabBarController)
    }
    
    // MARK: - Coordinator
    
    override func start() {
        self.showHomeViewController()
    }
    
    // MARK: - Init
    
    init(router: RouterProtocol, factory: Factory) {
        self.router = router
        self.factory = factory
    }
}
