//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Junho Lee on 2022/09/18.
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.makeModule(
    name: "ThirdPartyLib",
    product: .framework,
    packages: [],
    dependencies: [
        .external(name: "RxSwift"),
        .external(name: "RxCocoa"),
        .external(name: "SnapKit"),
        .external(name: "KakaoSDKUser"),
        .external(name: "KakaoSDKAuth"),
        .external(name: "HeeKit")
    ]
)
