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
    .remote(url: "https://github.com/kakao/kakao-ios-sdk", requirement: .upToNextMajor(from: "2.13.0")),
    .remote(url: "https://github.com/firebase/firebase-ios-sdk.git", requirement: .upToNextMinor(from: "9.6.0")),
    .remote(url: "https://github.com/EunHee-Jeong/HeeKit.git", requirement: .revision("e79a507")),
    .remote(url: "https://github.com/Quick/Quick.git", requirement: .upToNextMajor(from: "6.1.0")),
    .remote(url: "https://github.com/Quick/Nimble.git", requirement: .upToNextMajor(from: "11.0.0")),
    .remote(url: "https://github.com/airbnb/lottie-ios", requirement: .upToNextMajor(from:"4.0.1"))
])

let dependencies = Dependencies(
    carthage: [],
    swiftPackageManager: spm,
    platforms: [.iOS]
)
