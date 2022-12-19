//
//  AppDelegate.swift
//  ProjectDescriptionHelpers
//
//  Created by Junho Lee on 2022/09/18.
//

import UIKit

import RD_Core

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
    
    // foreground에 푸시을 받는 경우 처리
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner, .sound, .badge])
    }
    
    // background에서 푸시를 받는 경우 처리
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
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
