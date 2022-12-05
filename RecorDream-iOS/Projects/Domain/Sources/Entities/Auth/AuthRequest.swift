//
//  AuthRequest.swift
//  Domain
//
//  Created by 정은희 on 2022/12/05.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

public struct AuthRequest: Codable {
    public var kakaoToken: String? = nil
    public var appleToken: String? = nil
    public let fcmToken: String
    
    public init(kakaoToken: String?, appleToken: String?, fcmToken: String) {
        self.kakaoToken = kakaoToken
        self.appleToken = appleToken
        self.fcmToken = fcmToken
    }
}
