//
//  ViewControllerFactory.swift
//  RouterCoordinator
//
//  Created by Junho Lee on 2022/09/29.
//

import Foundation

import Presentation

// TODO: - Login Flow에 사용될 Factory Protocol, 추후에 구현
protocol AuthViewControllerFactory {
//    func instantiateSpalshViewController() -> SplashViewController
}

protocol MainTabBarControllerFactory {
    func instantiateMainTabBarController() -> MainTabBarController
    func instantiateDreamWriteVC(_ type: DreamWriteViewModel.DreamWriteViewModelType) -> DreamWriteVC
    func instantiateMyPageVC() -> MyPageVC
}
