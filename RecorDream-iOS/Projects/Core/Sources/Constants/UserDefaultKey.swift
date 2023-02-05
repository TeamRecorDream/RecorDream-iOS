//
//  Key.swift
//  RD-Core
//
//  Created by 정은희 on 2022/12/05.
//  Copyright © 2022 RecorDream. All rights reserved.
//

public enum UserDefaultKey: String {
    // Version
    case checkedAppVersion = "checkedAppVersion"
    
    // Auth-User
    case platform = "key.platform"
    case userToken = "key.userToken"
    case accessToken = "key.accessToken"
    case refreshToken = "key.refreshToken"
    case nickname = "key.nickname"
    
    // Coordinator
    
    case shouldShowWrite = "key.shouldShowWrite"
    
    // Analytics
    case userId = "userId"
    case fromPushNotice = "fromPushNotice"
}

public extension UserDefaultKey {
    enum Constants {
        static var kakao = "kakao"
        static var apple = "apple"
    }
}
