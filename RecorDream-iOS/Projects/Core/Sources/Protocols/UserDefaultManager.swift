//
//  UserDefaultManager.swift
//  RD-Core
//
//  Created by 정은희 on 2022/12/05.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

public protocol UserDefaultManager {
    static func set(value: Any, keyPath: UserDefaultKey)
    static func string(key: UserDefaultKey) -> String?
    static func int(key: UserDefaultKey) -> Int?
    static func remove(key: UserDefaultKey)
    static func clearUserData()
}

public class DefaultUserDefaultManager: UserDefaultManager {
    public static func set(value: Any, keyPath: UserDefaultKey) {
        UserDefaults.standard.setValue(value, forKeyPath: keyPath.rawValue)
    }
    public static func string(key: UserDefaultKey) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
    public static func int(key: UserDefaultKey) -> Int? {
        return UserDefaults.standard.integer(forKey: key.rawValue)
    }
    public static func remove(key: UserDefaultKey) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    public static func clearUserData() {
        self.remove(key: .platform)
        self.remove(key: .accessToken)
        self.remove(key: .refreshToken)
        self.remove(key: .nickname)
    }
}

public extension DefaultUserDefaultManager {
    static var accessToken: String? {
        return string(key: .accessToken)
    }
    
    static var refreshToken: String? {
        return string(key: .refreshToken)
    }
    
    static var isKakaoUser: Bool {
        return string(key: .platform) == UserDefaultKey.Constants.kakao
    }
}
