//
//  UserDefaultManager.swift
//  RD-Core
//
//  Created by 정은희 on 2022/12/05.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

public protocol UserDefaultManager {
    static func set(value: Any, keyPath: Key.RawValue)
    static func string(key: Key) -> String?
    static func int(key: Key) -> Int?
    static func remove(key: Key)
    static func clearUserData()
}

public class DefaultUserDefaultManager: UserDefaultManager {
    public static func set(value: Any, keyPath: Key.RawValue) {
        UserDefaults.standard.setValue(value, forKeyPath: keyPath)
    }
    public static func string(key: Key) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
    public static func int(key: Key) -> Int? {
        return UserDefaults.standard.integer(forKey: key.rawValue)
    }
    public static func remove(key: Key) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    public static func clearUserData() {
        self.remove(key: .platform)
        self.remove(key: .userToken)
        self.remove(key: .accessToken)
        self.remove(key: .nickname)
    }
}
