//
//  DreamWriteSection.swift
//  Presentation
//
//  Created by Junho Lee on 2022/10/08.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

enum Section: String, CaseIterable {
    case main
    case emotions = "나의 감정"
    case genres = "꿈의 장르"
    case note = "노트"
    
    var title: String {
        return self.rawValue
    }
    
    static func type(_ index: Int) -> Section {
        return self.allCases[index]
    }
}
