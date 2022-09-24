//
//  TypoStyle+.swift
//  Presentation
//
//  Created by 정은희 on 2022/09/23.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

extension TypoStyle {
    private var fontDescription: FontDescription {
        switch self {
        case .tittle01:
            return FontDescription(font: .pretendardSemibold, size: 18)
        case .title02:
            return FontDescription(font: .pretendardBold, size: 16)
        case .title03:
            return FontDescription(font: .pretendardSemibold, size: 16)
        case .title04:
            return FontDescription(font: .pretendardSemibold, size: 14)
        case .title05:
            return FontDescription(font: .pretendardSemibold, size: 12)
        case .title06:
            return FontDescription(font: .pretendardSemibold, size: 10)
        case .body01:
            return FontDescription(font: .pretendardMedium, size: 14)
        case .body02:
            return FontDescription(font: .pretendardMedium, size: 14)
        case .body03:
            return FontDescription(font: .pretendardRegular, size: 14)
        case .body04:
            return FontDescription(font: .pretendardRegular, size: 12)
        case .body05:
            return FontDescription(font: .pretendardRegular, size: 12)
        case .body06:
            return FontDescription(font: .pretendardRegular, size: 11)
        case .body07:
            return FontDescription(font: .pretendardMedium, size: 10)
        case .body08:
            return FontDescription(font: .pretendardRegular, size: 10)
        case .tag01:
            return FontDescription(font: .pretendardRegular, size: 14)
        case .tag02:
            return FontDescription(font: .pretendardMedium, size: 8)
        case .cap01:
            return FontDescription(font: .pretendardMedium, size: 16)
        case .cap02:
            return FontDescription(font: .pretendardLight, size: 10)
        case .intro01:
            return FontDescription(font: .pretendardSemibold, size: 24)
        case .intro02:
            return FontDescription(font: .pretendardExtraLight, size: 24)
        case .modal01:
            return FontDescription(font: .pretendardSemibold, size: 26)
        case .modal02:
            return FontDescription(font: .pretendardLight, size: 22)
        }
    }
    
    var font: UIFont {
        guard let font = UIFont(name: fontDescription.font.name, size: fontDescription.size) else {
            return UIFont()
        }
        return font
    }
}
