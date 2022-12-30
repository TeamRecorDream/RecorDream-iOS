//
//  AppDelegate.swift
//  ProjectDescriptionHelpers
//
//  Created by Junho Lee on 2022/09/18.
//

import UIKit

import RD_Core
import RD_Navigator

import FirebaseCore
import FirebaseMessaging
import KakaoSDKCommon
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application( _ application: UIApplication,
                      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        KakaoSDK.initSDK(appKey: Constants.KAKAO_APP_KEY)
        self.configureFirebase()
        self.registerAPNs(to: application)
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {}
}

// MARK: - APNs

extension AppDelegate: UNUserNotificationCenterDelegate {
    func registerAPNs(to application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                print("permission granted: \(granted)")
            }
        
        application.registerForRemoteNotifications()
    }
    
    // APNS 등록 실패 시 호출
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for notifications: \(error.localizedDescription)")
    }
    
    // APNS 등록 성공 시 호출
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenPart = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenPart.joined()
        print("Device Token:", token)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner, .sound, .badge])
    }
    
    // Push Notice를 탭한 경우의 처리
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let application = UIApplication.shared
        let scene = UIApplication.shared.connectedScenes.first
        let state = application.applicationState
        
        // 앱이 실행중인 상태에서 푸쉬 알림을 눌렀을 때
        // - active : 앱을 현재 활성화하여 사용중인 상태
        // - inactive : 실행중이지만 비활성화 상태
        if state == .active || state == .inactive {
            guard let sceneDelegate = scene?.delegate as? SceneDelegate,
                  let factory = sceneDelegate.dependencyConatiner else {
                completionHandler()
                return
            }
            
            factory.coordinateDreamWriteVC()
        }
        completionHandler()
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        Messaging.messaging().appDidReceiveMessage(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
}

// MARK: - Firebase

extension AppDelegate: MessagingDelegate {
    func configureFirebase() {
        FirebaseApp.configure()
        self.configureFirebaseMessaging()
    }
    
    func configureFirebaseMessaging() {
        Messaging.messaging().delegate = self
        
        Messaging.messaging().token { token, error in
            if let error = error {
                print("FCM 등록토큰 가져오기 오류: \(error)")
            } else if let token = token {
                print("FCM 등록토큰 : \(token)")
                UserDefaults.standard.set(token, forKey: UserDefaultKey.userToken.rawValue)
            }
        }
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let token = fcmToken else { return }
        print("FCM 등록토큰 갱신: \(token)")
        UserDefaults.standard.set(token, forKey: UserDefaultKey.userToken.rawValue)
    }
}
