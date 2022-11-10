//
//  MyPageEntity.swift
//  PresentationTests
//
//  Created by Junho Lee on 2022/10/09.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

public struct MyPageEntity {
    public let userName: String
    public let email: String
    public let pushOnOff: Bool
    public let pushTime: String?
    
    public init(userName: String, email: String, pushOnOff: Bool, pushTime: String?) {
        self.userName = userName
        self.email = email
        self.pushOnOff = pushOnOff
        self.pushTime = pushTime
    }
}
