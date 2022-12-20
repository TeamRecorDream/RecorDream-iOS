//
//  AuthResponse.swift
//  RD-Network
//
//  Created by 정은희 on 2022/12/04.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

public struct AuthResponse: Codable {
    public let duplicated: Bool
    public let accessToken: String
    public let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case duplicated = "isAlreadyUser"
        case accessToken, refreshToken
    }
}
