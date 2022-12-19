//
//  UserInfoTransform.swift
//  Data
//
//  Created by Junho Lee on 2022/12/19.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

import Domain
import RD_Network

import Foundation

extension UserInfoResponse {
    func toDomain() -> MyPageEntity? {
        var notEmptyName = self.nickname
        notEmptyName = self.nickname == ""
        ? "닉네임"
        : self.nickname
        return .init(userName: notEmptyName,
                     email: self.email,
                     pushOnOff: self.time != nil,
                     pushTime: self.time)
    }
}
