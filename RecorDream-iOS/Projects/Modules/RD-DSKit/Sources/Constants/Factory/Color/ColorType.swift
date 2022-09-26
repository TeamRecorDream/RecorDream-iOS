//
//  ColorType.swift
//  Presentation
//
//  Created by 정은희 on 2022/09/23.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

public enum ColorType: String, CaseIterable {
    case dark = "dark"
    case grey01 = "grey01"
    case grey02 = "grey02"
    case purple = "purple"
    case red = "red"
    case white01 = "white01"
    case white02 = "white02"
    case white03 = "white03"
    case white04 = "white04"
    case white05 = "white05"
    case white06 = "white06"
    
    var name: String {
        return self.rawValue
    }
}
