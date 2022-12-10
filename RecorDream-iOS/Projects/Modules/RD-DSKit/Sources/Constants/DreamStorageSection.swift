//
//  DreamStorageSection.swift
//  RD-DSKit
//
//  Created by 정은희 on 2022/12/10.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

public enum DreamStorageSection: String, CaseIterable {
    case filters = "나의 감정"
    case cards
    
    public static func type(_ index: Int) -> DreamStorageSection {
        return self.allCases[index]
    }
    public var title: String {
        return self.rawValue
    }
}

extension DreamStorageSection {
    public static let titles = ["기쁜", "슬픈", "무서운", "이상한", "민망한", "미설정"]
    static let icons = [RDDSKitAsset.Images.feelingXsJoySelected.image,
                                RDDSKitAsset.Images.feelingXsSadSelected.image,
                                RDDSKitAsset.Images.feelingXsScarySelected.image,
                                RDDSKitAsset.Images.feelingXsStrangeSelected.image,
                        RDDSKitAsset.Images.feelingXsShySelected.image, RDDSKitAsset.Images.feelingXsBlank.image]
}
