//
//  ViewControllerFactory.swift
//  RouterCoordinator
//
//  Created by Junho Lee on 2022/09/29.
//

import Foundation

public typealias ViewControllerFactory = AuthViewControllerFactory  & MainTabBarControllerFactory

// TODO: - Login Flow에 사용될 Factory Protocol, 추후에 구현
public protocol AuthViewControllerFactory {
    func instantiateSpalshVC() -> SplashVC
    func instantiateLoginVC() -> LoginVC
}

public protocol MainTabBarControllerFactory {
    func instantiateMainTabBarController() -> MainTabBarController
    func instantiateDreamWriteVC(_ type: DreamWriteViewModel.DreamWriteViewModelType) -> DreamWriteVC
    func instantiateMyPageVC() -> MyPageVC
}
