//
//  NSBundle+.swift
//  RD-Core
//
//  Created by Junho Lee on 2023/02/05.
//  Copyright © 2023 RecorDream-iOS. All rights reserved.
//

import Foundation

public extension Bundle {
    static var appVersion: String? {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    static var buildVersion: String? {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    }
}
