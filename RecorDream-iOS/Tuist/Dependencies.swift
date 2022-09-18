//
//  Dependencies.swift
//  Config
//
//  Created by Junho Lee on 2022/09/19.
//

import ProjectDescription
import ProjectDescriptionHelpers

let spm = SwiftPackageManagerDependencies([
    .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMinor(from: "5.0.0")),
    .remote(url: "https://github.com/ReactiveX/RxSwift.git", requirement: .upToNextMinor(from: "6.5.0")),
    .remote(url: "https://github.com/kakao/kakao-ios-sdk", requirement: .upToNextMinor(from: "2.11.0")),
    .remote(url: "https://github.com/firebase/firebase-ios-sdk.git", requirement: .upToNextMinor(from: "9.2.0"))
])

let dependencies = Dependencies(
    carthage: [],
    swiftPackageManager: spm,
    platforms: [.iOS]
)
