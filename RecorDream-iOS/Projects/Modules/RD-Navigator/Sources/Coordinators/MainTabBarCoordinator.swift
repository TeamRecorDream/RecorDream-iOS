//
//  WalktroughCoordinator.swift
//  RouterCoordinator
//
//  Created by Junho Lee on 2022/09/29.
//

import Foundation

import Presentation

import RxSwift

/// MainTabBar의 코디네이터입니다. 시작점은 홈VC 입니다.
final class MainTabBarCoordinator: DefaultCoordinator {
    
    // MARK: - CoordinatorFinishOutput
    
    var finishFlow: (() -> Void)?
    
    // MARK: - Vars & Lets
    
    private let router: RouterProtocol
    private let factory: Factory
    private let disposeBag = DisposeBag()
    
    // MARK: - Private metods
    
    /// 탭바를 push 형식으로 띄웁니다. 탭바의 middleButtonAction을 구독하여 눌린 경우 DreamWriteVC를 띄웁니다.
    private func showHomeViewController() {
        let mainTabBarController = self.factory.instantiateMainTabBarController()
        mainTabBarController.viewModel.middleButtonTapped
            .subscribe(onNext: { [unowned self] in
                self.showDreamWriteViewController()
            }).disposed(by: disposeBag)
        self.router.push(mainTabBarController)
    }
    
    /// DreamWriteVC를 present 형식으로 띄웁니다. DreamWriteVC가 화면에서 해제된 경우를 구독합니다.
    private func showDreamWriteViewController() {
        let dreamWriteVC = self.factory.instantiateDreamWriteVC(.write)
        dreamWriteVC.modalPresentationStyle = .fullScreen
//        dreamWriteVC.viewModel.closeButtonTapped
//            .subscribe(onNext: { [unowned self] in
//                dreamWriteVC.dismiss(animated: true)
//            }).disposed(by: disposeBag)
//        dreamWriteVC.viewModel.writeRequestSuccess
//            .subscribe(onNext: { [unowned self] in
//                dreamWriteVC.dismiss(animated: true)
//            }).disposed(by: disposeBag)
        self.router.present(dreamWriteVC)
    }
    
    private func showMyPageViewController() {
        let myPageVC = self.factory.instantiateMyPageVC()
//        myPageVC.viewModel.logoutCompleted
//            .subscribe(onNext: { [unowned self] in
//                self.router.popModule()
//            }).disposed(by: disposeBag)
//        myPageVC.viewModel.withdrawalCompleted
//            .subscribe(onNext: { [unowned self] in
//                self.router.popModule()
//            }).disposed(by: disposeBag)
        self.router.push(myPageVC)
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
