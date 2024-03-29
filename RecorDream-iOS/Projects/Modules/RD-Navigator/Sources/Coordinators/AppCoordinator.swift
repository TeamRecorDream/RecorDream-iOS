//
//  ApplicationCoordinator.swift
//  RouterCoordinator
//
//  Created by Junho Lee on 2022/09/29.
//

import Foundation

/// App의 시작 시에 사용되는 코디네이터입니다. 자동로그인 등의 기능에서 분기를 결정합니다.
/// 현재 start() 메서드가 실행되면 runMainFlow()가 실행됩니다. 탭바로 이동합니다.
final class AppCoordinator: BaseCoordinator {
    
    // MARK: - Vars & Lets
    
    private let factory: Factory
    private let router: RouterProtocol
    private var launchInstructor: LaunchInstructor
    
    // MARK: - Coordinator
    
    override func start(with option: DeepLinkOption?) {
        if option != nil {
            
        } else {
            switch launchInstructor {
            case .onboarding: runOnboardingFlow()
            case .auth: runAuthFlow()
            case .main: runMainFlow()
            }
        }
    }
    
    // MARK: - Private methods
    
    /// App의 Auth Flow로 가는 분기입니다. LoginVC로 전환됩니다.
    private func runAuthFlow() {
        let coordinator = self.factory.instantiateAuthCoordinator(router: self.router)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            self.removeDependency(coordinator)
            self.launchInstructor = LaunchInstructor.configure(isAutorized: true, tutorialWasShown: false)
            self.start()
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
    
    /// App의 Onboarding Flow로 가는 분기입니다. OnboardingVC로 전환됩니다.
    private func runOnboardingFlow() {
        let coordinator = self.factory.instantiateMainTabBarCoordinator(router: self.router)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            self.removeDependency(coordinator)
            self.launchInstructor = LaunchInstructor.configure(isAutorized: true, tutorialWasShown: true)
            self.start()
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
    
    /// App의 MainFlow로 가는 분기입니다. MainTabBar로 전환됩니다.
    private func runMainFlow() {
        let coordinator = self.factory.instantiateMainTabBarCoordinator(router: self.router)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            self.removeDependency(coordinator)
            self.launchInstructor = LaunchInstructor.configure(isAutorized: true, tutorialWasShown: true)
            self.start()
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
    
    // MARK: - Init
    
    init(router: RouterProtocol, factory: Factory, launchInstructor: LaunchInstructor) {
        self.router = router
        self.factory = factory
        self.launchInstructor = launchInstructor
    }
    
}
