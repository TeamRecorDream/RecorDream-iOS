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
        self.window = UIWindow(windowScene: windowScene)
        
        rootController = CoordinatorNavigationController(rootViewController: SplashVC())
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.rootController = CoordinatorNavigationController(rootViewController: UIViewController())
        }
        
        self.window?.rootViewController = self.rootController
        self.window?.makeKeyAndVisible()

        dependencyConatiner = DependencyContainer(rootController: self.rootController!)

        self.dependencyConatiner?.start()
        
        // MARK: - Debug 관련
        // Coordinator를 사용하지 않고 앱을 시작하기 위해서 아래 코드를 주석해제하고 사용해주세요
//        let rootViewController = MainTabBarController()
//        let window = UIWindow(windowScene: windowScene)
//        window.rootViewController = rootViewController
//        self.window = window
//        window.backgroundColor = .white
//        window.makeKeyAndVisible()
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
