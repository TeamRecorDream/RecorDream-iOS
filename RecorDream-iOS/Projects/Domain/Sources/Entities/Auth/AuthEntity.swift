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
    
    public init(duplicated: Bool, accessToken: String, refreshToken: String) {
        self.duplicated = duplicated
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}
