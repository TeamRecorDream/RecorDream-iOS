//
//  AuthEntity.swift
//  Domain
//
//  Created by 정은희 on 2022/12/04.
//  Copyright © 2022 RecorDream. All rights reserved.
//

public struct AuthEntity: Codable {
    public let duplicated: Bool
    public let accessToken: String
    public let refreshToken: String
    public let nickname: String
    
    public init(duplicated: Bool, accessToken: String, refreshToken: String, nickname: String) {
        self.duplicated = duplicated
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.nickname = nickname
    }
}
