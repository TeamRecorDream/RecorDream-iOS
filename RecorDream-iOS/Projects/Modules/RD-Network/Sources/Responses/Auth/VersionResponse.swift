//
//  VersionResponse.swift
//  RD-Network
//
//  Created by Junho Lee on 2023/02/05.
//  Copyright © 2023 RecorDream-iOS. All rights reserved.
//

import Foundation

// MARK: - VersionResponse
public struct VersionResponse: Codable {
    public let iOSForceAppVersion,
               iOSAppVersion,
               androidForceAppVersion,
               androidAppVersion: String

    enum CodingKeys: String, CodingKey {
        case iOSForceAppVersion = "iOS_force_app_version"
        case iOSAppVersion = "iOS_app_version"
        case androidForceAppVersion = "android_force_app_version"
        case androidAppVersion = "android_app_version"
    }
}
