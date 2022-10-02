//
//  WalktroughViewControllerFactoryImpl.swift
//  RouterCoordinator
//
//  Created by Junho Lee on 2022/09/29.
//

import UIKit

/*
 CoordinatorFactory를 채택하여 Coordinator를 생성할 수 있도록 합니다.
 DependencyContainer는 스스로를 Factory로 각각의 Coordinator 안에서 기능합니다.
 따라서 각 Coordinator들은 Dependency Container가 가진 인스턴스들을 사용할 수 있습니다.
 */
extension DependencyContainer: CoordinatorFactoryProtocol {
    
    /// 앱 전체의 플로우를 담당하는 AppCoordinator를 생성합니다.
    /// - Returns: AppCoordinator는 각기 다른 플로우를 담당하는 Coordinator로의 이동을 담당합니다.
    func instantiateAppCoordinator() -> AppCoordinator {
        return AppCoordinator(router: Router(rootController: rootController),
                                      factory: self as Factory,
                                      launchInstructor: LaunchInstructor.configure())
    }
    
    /// 로그인 플로우를 담당하는 AuthCoordinator를 생성합니다.
    /// - Parameter router: 라우터는 코디네이터가 이동해야할 뷰컨트롤러로의 분기를 담당합니다.
    func instantiateAuthCoordinator(router: RouterProtocol) -> AuthCoordinator {
        return AuthCoordinator(router: router,
                               factory: self)
    }
    
    /// 메인 플로우를 담당하는 MainTabBarCoordinator를 생성합니다.
    /// - Parameter router: 라우터는 코디네이터가 이동해야할 뷰컨트롤러로의 분기를 담당합니다.
    func instantiateMainTabBarCoordinator(router: RouterProtocol) -> MainTabBarCoordinator {
        return MainTabBarCoordinator(router: router,
                                     factory: self)
    }
}
