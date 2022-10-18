//
//  Int+.swift
//  RD-Core
//
//  Created by Junho Lee on 2022/10/11.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

public extension Int {
    var secondsDigitInt: Int {
        self % 60
    }
    var miniuteDigitInt: Int {
        self / 60
    }
}
