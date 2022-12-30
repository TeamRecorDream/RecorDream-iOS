//
//  SceneDelegate.swift
//  ProjectDescriptionHelpers
//
//  Created by Junho Lee on 2022/09/18.
//

import UIKit
import UserNotifications

import Presentation
import RD_Navigator
import RD_Core

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
        //         Coordinator를 사용하기 위한 코드
        //        self.window = UIWindow(windowScene: windowScene)
        //
        //        rootController = CoordinatorNavigationController(rootViewController: UIViewController())
        //        self.window?.rootViewController = rootController
        //        self.window?.makeKeyAndVisible()
        //        self.dependencyConatiner?.start()
        
        self.checkEnteredWithPushNotice(connectionOptions)
        self.dependencyConatiner = DependencyContainer()
        let rootViewController = dependencyConatiner?.instantiateSpalshVC()
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = rootViewController
        self.window = window
        window.backgroundColor = .black
        window.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {}
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func sceneWillResignActive(_ scene: UIScene) {}
    
    func sceneWillEnterForeground(_ scene: UIScene) {}
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        DefaultUserDefaultManager.set(value: false, keyPath: .shouldShowWrite)
    }
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

extension SceneDelegate {
    private func checkEnteredWithPushNotice(_ connectionOptions: UIScene.ConnectionOptions) {
        if connectionOptions.notificationResponse != nil {
            DefaultUserDefaultManager.set(value: true, keyPath: .shouldShowWrite)
        }
    }
}
