//
//  ReissuanceResponse.swift
//  RD-Network
//
//  Created by Junho Lee on 2022/12/19.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

import Foundation

public struct ReissuanceResponse: Codable {
    public let accessToken, refreshToken: String
}
