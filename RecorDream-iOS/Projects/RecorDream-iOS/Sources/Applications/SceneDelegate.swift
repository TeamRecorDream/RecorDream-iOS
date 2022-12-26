//
//  SceneDelegate.swift
//  ProjectDescriptionHelpers
//
//  Created by Junho Lee on 2022/09/18.
//

import UIKit

import RD_Navigator
import Presentation

import KakaoSDKAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    var rootController: CoordinatorNavigationController?
    
    var dependencyConatiner: DependencyContainer?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        // MARK: - Debug 관련
//         Coordinator를 사용하기 위한 코드
//        self.window = UIWindow(windowScene: windowScene)
//
//        rootController = CoordinatorNavigationController(rootViewController: UIViewController())
//        self.window?.rootViewController = rootController
//        self.window?.makeKeyAndVisible()
//
        dependencyConatiner = DependencyContainer()
//
//        self.dependencyConatiner?.start()
        let rootViewController = dependencyConatiner?.instantiateSpalshVC()
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = rootViewController
        self.window = window
        window.backgroundColor = .white
        window.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {}
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func sceneWillResignActive(_ scene: UIScene) {}
    
    func sceneWillEnterForeground(_ scene: UIScene) {}
    
    func sceneDidEnterBackground(_ scene: UIScene) {}
}

extension SceneDelegate {
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if AuthApi.isKakaoTalkLoginUrl(url) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
}
