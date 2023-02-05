//
//  VersionCheckTransform.swift
//  Data
//
//  Created by Junho Lee on 2023/02/05.
//  Copyright © 2023 RecorDream-iOS. All rights reserved.
//

import Domain
import RD_Network

import Foundation

extension VersionResponse {
    func toDomain() -> VersionCheckEntity {
        return VersionCheckEntity.init(
            needForceUpdateVersion: self.iOSForceAppVersion,
            latestAppVersion: self.iOSAppVersion
        )
    }
}

