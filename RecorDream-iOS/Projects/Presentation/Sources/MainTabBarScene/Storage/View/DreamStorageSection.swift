//
//  DreamStorageSection.swift
//  RD-DSKit
//
//  Created by 정은희 on 2022/12/10.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

import RD_DSKit

public enum DreamStorageSection: String, CaseIterable {
    case filters = "나의 감정"
    case records
    
    public static func type(_ index: Int) -> DreamStorageSection {
        return self.allCases[index]
    }
    public var title: String {
        return self.rawValue
    }
}

extension DreamStorageSection {
    public static let titles = ["전체", "기쁜", "슬픈", "무서운", "이상한", "민망한", "미설정"]
    public static let icons = [RDDSKitAsset.Images.feelingXsAllSelected.image,
                               RDDSKitAsset.Images.feelingXsJoySelected.image,
                        RDDSKitAsset.Images.feelingXsSadSelected.image,
                        RDDSKitAsset.Images.feelingXsScarySelected.image,
                        RDDSKitAsset.Images.feelingXsStrangeSelected.image,
                        RDDSKitAsset.Images.feelingXsShySelected.image,
                        RDDSKitAsset.Images.feelingXsBlankSelected.image]
    public static let deselectedIcons = [RDDSKitAsset.Images.feelingXsAll.image,
                                         RDDSKitAsset.Images.feelingXsJoy.image,
                                  RDDSKitAsset.Images.feelingXsSad.image,
                                  RDDSKitAsset.Images.feelingXsScary.image,
                                  RDDSKitAsset.Images.feelingXsStrange.image,
                                  RDDSKitAsset.Images.feelingXsShy.image,
                                  RDDSKitAsset.Images.feelingXsBlank.image]
}
