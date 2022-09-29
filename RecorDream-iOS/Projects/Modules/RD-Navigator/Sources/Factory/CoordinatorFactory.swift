//
//  CoordinatorFactory.swift
//  RouterCoordinator
//
//  Created by Junho Lee on 2022/09/29.
//

import UIKit

protocol CoordinatorFactoryProtocol {
    func instantiateAppCoordinator() -> AppCoordinator
    func instantiateAuthCoordinator(router: RouterProtocol) -> AuthCoordinator
    func instantiateMainTabBarCoordinator(router: RouterProtocol) -> MainTabBarCoordinator
}
