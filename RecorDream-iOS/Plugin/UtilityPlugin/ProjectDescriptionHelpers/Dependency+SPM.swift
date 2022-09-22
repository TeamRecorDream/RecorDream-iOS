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
    static let SnapKit = TargetDependency.external(name: "SnapKit")
    static let FirebaseAnalytics = TargetDependency.external(name: "FirebaseAnalytics")
    static let FirebaseCrashlytics = TargetDependency.external(name: "FirebaseCrashlytics")
    static let FirebaseRemoteConfig = TargetDependency.external(name: "FirebaseRemoteConfig")
    static let KakaoUser = TargetDependency.external(name: "KakaoSDKUser")
    static let KakaoAuth = TargetDependency.external(name: "KakaoSDKAuth")
    static let HeeKit = TargetDependency.external(name: "HeeKit")
}
