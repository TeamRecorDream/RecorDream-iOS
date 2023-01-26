//
//  Data.swift
//  ProjectDescriptionHelpers
//
//  Created by Junho Lee on 2022/09/18.
//

import Foundation
import FirebaseCore
import FirebaseAnalytics
import FirebaseCrashlytics

open class AnalyticsManager {
    public static func setFirebaseUserProperty() {
        let userId = String(UserDefaults.standard.integer(forKey: "userId"))
        let os = "iOS"
        let osVersion = UIDevice.iOSVersion
        let deviceInfo = UIDevice.iPhoneModel
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "errorVersion"
        Analytics.setUserProperty(userId, forName: "userId")
        Analytics.setUserProperty(os, forName: "os")
        Analytics.setUserProperty(osVersion, forName: "osVersion")
        Analytics.setUserProperty(deviceInfo, forName: "device")
        Analytics.setUserProperty(appVersion, forName: "appVersion")
    }
    
    public static func log(event: FirebaseEventType) {
        Analytics.logEvent(event.name(), parameters: event.parameters())
    }
}


