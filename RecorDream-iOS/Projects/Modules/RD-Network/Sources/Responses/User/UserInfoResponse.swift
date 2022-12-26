//
//  UserInfoResponse.swift
//  RD-Network
//
//  Created by Junho Lee on 2022/12/19.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

import Foundation

public struct UserInfoResponse: Codable {
    public let nickname, email: String
    public let time: String?
}
