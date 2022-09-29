//
//  AuthCoordinator.swift
//  RouterCoordinator
//
//  Created by Junho Lee on 2022/09/29.
//

import Foundation

/*
 아래 코드들은 예시로 남겨두겠습니다.
 현재 구현한 방식은 viewModel에 publishRelay를 둬서 구독하는 방식인데, 아래 코드들은 뷰컨트롤러의 클로저에 화면전환 액션을 넣는 방식입니다.
 */
final class AuthCoordinator: DefaultCoordinator {
    
    // MARK: - CoordinatorFinishOutput
    
    var finishFlow: (() -> Void)?
    
    // MARK: - Vars & Lets
    
    private let router: RouterProtocol
    private let factory: Factory
    
    // MARK: - Private methods
    
//    private func showLoginRegisterViewController() {
//        let showLoginRegisterViewController = self.factory.instantiateChooseLoginRegisterViewController()
//        showLoginRegisterViewController.onRegister = { [unowned self] in
//            self.showRegisterViewController()
//        }
//        showLoginRegisterViewController.onLogin = { [unowned self] in
//            self.showLoginViewController()
//        }
//        showLoginRegisterViewController.onTermsAndConditions = { [weak self] in
//            self?.presentTermsAndConditionsViewController()
//        }
//        self.router.setRootModule(showLoginRegisterViewController, hideBar: false, animated: false)
//    }
//
//    private func showLoginViewController() {
//        let loginViewController = self.factory.instantiateLoginViewController()
//        loginViewController.onBack = { [unowned self] in
//            self.router.popModule(transition: FadeAnimator(animationDuration: 0.2, isPresenting: false))
//        }
//        loginViewController.onLogin = {
//            self.presentWalktroughViewController()
//        }
//        self.router.push(loginViewController, transition: FadeAnimator(animationDuration: 0.2, isPresenting: true))
//    }
//
//    private func showRegisterViewController() {
//        let registerViewController = self.factory.instantiateRegisterViewController()
//        registerViewController.onBack = { [unowned self] in
//            self.router.popModule()
//        }
//        registerViewController.onRegister = {
//            self.presentWalktroughViewController()
//        }
//        self.router.push(registerViewController)
//    }
//
//    private func presentTermsAndConditionsViewController() {
//        let termsAndConditionsViewController = self.factory.instantiateTermsAndConditionsViewController()
//        termsAndConditionsViewController.onClose = { [weak self] in
//            self?.router.dismissModule()
//        }
//        self.router.present(termsAndConditionsViewController)
//    }
//
//    private func presentWalktroughViewController() {
//        let coordinator = self.factory.instantiateMainTabBarCoordinator(router: self.router)
//        coordinator.finishFlow = { [weak self, weak coordinator] in
//            self?.removeDependency(coordinator)
//        }
//        self.addDependency(coordinator)
//        coordinator.start()
//    }
    
    // MARK: - Coordinator
    
    override func start() {
//        self.showLoginRegisterViewController()
    }
    
    // MARK: - Init
    
    init(router: RouterProtocol, factory: Factory) {
        self.router = router
        self.factory = factory
    }
    
}
