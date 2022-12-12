//
//  Dependency+SPM.swift
//  ProjectDescriptionHelpers
//
//  Created by Junho Lee on 2022/09/21.
//

import ProjectDescription

public extension TargetDependency {
    enum SPM {}
}

public extension TargetDependency.SPM {
    static let RxSwift = TargetDependency.external(name: "RxSwift")
    static let RxCocoa = TargetDependency.external(name: "RxCocoa")
    static let RxRelay = TargetDependency.external(name: "RxRelay")
    static let RxTest = TargetDependency.external(name: "RxTest")
    static let RxBlocking = TargetDependency.external(name: "RxBlocking")
    static let Nimble = TargetDependency.external(name: "Nimble")
    static let Quick = TargetDependency.external(name: "Quick")
    static let SnapKit = TargetDependency.external(name: "SnapKit")
    static let FirebaseAnalytics = TargetDependency.external(name: "FirebaseAnalytics")
    static let FirebaseCrashlytics = TargetDependency.external(name: "FirebaseCrashlytics")
    static let FirebaseRemoteConfig = TargetDependency.external(name: "FirebaseRemoteConfig")
    static let FirebaseMessaging = TargetDependency.external(name: "FirebaseMessaging")
    static let KakaoUser = TargetDependency.external(name: "KakaoSDKUser")
    static let KakaoAuth = TargetDependency.external(name: "KakaoSDKAuth")
    static let HeeKit = TargetDependency.external(name: "HeeKit")
}
