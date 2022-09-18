//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Junho Lee on 2022/09/18.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "ThirdPartyLib",
    product: .framework,
    packages: [],
    dependencies: [
        .external(name: "RxSwift"),
        .external(name: "RxCocoa"),
        .external(name: "SnapKit"),
        .external(name: "FirebaseAnalytics"),
        .external(name: "FirebaseCrashlytics"),
        .external(name: "FirebaseRemoteConfig"),
        .external(name: "KakaoSDKUser"),
        .external(name: "KakaoSDKAuth"),
        .external(name: "HeeKit")
    ]
)
