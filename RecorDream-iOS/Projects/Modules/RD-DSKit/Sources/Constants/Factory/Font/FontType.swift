//
//  FontType.swift
//  Presentation
//
//  Created by 정은희 on 2022/09/23.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

public enum FontType: String {
    case pretendardBold = "Pretendard-Bold"
    case pretendardSemibold = "Pretendard-SemiBold"
    case pretendardLight = "Pretendard-Light"
    case pretendardExtraBold = "Pretendard-ExtraBold"
    case pretendardMedium = "Pretendard-Medium"
    case pretendardRegular = "Pretendard-Regular"
    case pretendardExtraLight = "Pretendard-ExtraLight"
    
    var name: String {
        return self.rawValue
    }
}

public struct FontDescription {
    let font: FontType
    let size: CGFloat
}
