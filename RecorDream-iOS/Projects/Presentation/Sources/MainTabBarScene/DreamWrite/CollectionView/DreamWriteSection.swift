//
//  DreamWriteSection.swift
//  Presentation
//
//  Created by Junho Lee on 2022/10/08.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

import RD_DSKit

enum Section: String, CaseIterable {
    case main
    case emotions = "나의 감정"
    case genres = "꿈의 장르"
    case note = "노트"
    
    static func type(_ index: Int) -> Section {
        return self.allCases[index]
    }
    
    var title: String {
        return self.rawValue
    }
    
    // MARK: - Emitions
    
    static let emotionTitles = ["기쁜", "슬픈", "무서운", "이상한", "민망한"]
    
    static let emotionImages = [RDDSKitAsset.Images.feelingBright.image,
                                RDDSKitAsset.Images.feelingSad.image,
                                RDDSKitAsset.Images.feelingFright.image,
                                RDDSKitAsset.Images.feelingWeird.image,
                                RDDSKitAsset.Images.feelingShy.image]
    
    static let emotionDeselectedImages = [RDDSKitAsset.Images.feelingXsBright.image,
                                          RDDSKitAsset.Images.feelingXsSad.image,
                                          RDDSKitAsset.Images.feelingXsFright.image,
                                          RDDSKitAsset.Images.feelingXsWeird.image,
                                          RDDSKitAsset.Images.feelingXsShy.image]
    
    // MARK: - Genres
    
    static let genreTitles = ["코미디", "로맨스", "판타지", "가족", "친구", "공포", "동물", "음식", "일", "기타"]
        .map { "# " + $0 }
}
