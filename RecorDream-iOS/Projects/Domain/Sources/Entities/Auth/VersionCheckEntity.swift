//
//  VersionCheckEntity.swift
//  Domain
//
//  Created by Junho Lee on 2023/02/05.
//  Copyright © 2023 RecorDream-iOS. All rights reserved.
//

import Foundation

public struct VersionCheckEntity: Codable {
    public let needForceUpdateVersion: String
    public let latestAppVersion: String
    
    public init(needForceUpdateVersion: String, latestAppVersion: String) {
        self.needForceUpdateVersion = needForceUpdateVersion
        self.latestAppVersion = latestAppVersion
    }
}
