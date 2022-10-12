//
//  DependencyContainer.swift
//  RouterCoordinator
//
//  Created by Junho Lee on 2022/09/29.
//

import UIKit

import RD_DSKit

typealias Factory = CoordinatorFactoryProtocol & ViewControllerFactory
typealias ViewControllerFactory = AuthViewControllerFactory  & MainTabBarControllerFactory

/**
 각종 인스턴스의 의존성을 보유하는 Container Class 입니다.
 
 1. Coordinator를 보유하여 start 메서드를 통해 앱의 플로우를 실행할 수 있습니다.
 2. 이외에 다른 Service나 Manager를 보유하여 의존성을 관리합니다.
 3. CoordinatorNavigationController를 보유하여 Coordinator에서도 기능하는 NavigationController를 가집니다.
 
 Coordinator Factory Protocol을 채택하여 Coordinator를 생성할 수 있도록 구현해야 합니다.
 ViewController Factory Protocol을 채택하여 ViewController를 생성할 수 있도록 구현해야 합니다.
 
 결론적으로 DependencyContainer는 Factory로 기능합니다.
 */
open class DependencyContainer {
    
    // MARK: - Vars & Lets
    
    var rootController: CoordinatorNavigationController
    
    // MARK: App Coordinator
    
    internal lazy var aplicationCoordinator = self.instantiateAppCoordinator()
    
    // MARK: APi Manager
    
//    internal lazy var sessionManager = SessionManager()
    
    // MARK: Network services
    
//    internal lazy var authNetworkServices = AuthNetworkServices(apiManager: self.apiManager)
    
    // MARK: - Public func
    
    public func start() {
        self.aplicationCoordinator.start()
    }
    
    // MARK: - Initialization
    
    public init(rootController: CoordinatorNavigationController) {
        self.rootController = rootController
        self.customizeNavigationController()
    }
}

// MARK: - Private methods

extension DependencyContainer {
    private func customizeNavigationController() {
        self.rootController.enableSwipeBack()
        self.rootController.customizeTitle(titleColor: UIColor.white,
                                           largeTextFont: RDDSKitFontFamily.Pretendard.semiBold.font(size: 16),
                                           smallTextFont: RDDSKitFontFamily.Pretendard.semiBold.font(size: 16),
                                           isTranslucent: true,
                                           barTintColor: RDDSKitAsset.Colors.dark.color)
        self.rootController.customizeBackButton(backButtonImage: RDDSKitAsset.Images.icnBack.image, backButtonTitleColor: .white,
                                      shouldUseViewControllerTitles: true)
    }
}
