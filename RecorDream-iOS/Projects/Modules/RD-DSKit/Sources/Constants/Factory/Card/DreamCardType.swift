//
//  CardType.swift
//  RD-DSKitTests
//
//  Created by 김수연 on 2022/12/09.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_DSKit

public enum DreamCardType {
    case joy
    case sad
    case scary
    case strange
    case shy
    case blank
}

public extension DreamCardType {
    var background: UIImage {
        switch self {
        case .joy:
            return RDDSKitAsset.Images.backgroundYellow.image
        case .sad:
            return RDDSKitAsset.Images.backgroundBlue.image
        case .scary:
            return RDDSKitAsset.Images.backgroundRed.image
        case .strange:
            return RDDSKitAsset.Images.backgroundPurple.image
        case .shy:
            return RDDSKitAsset.Images.backgroundPink.image
        case .blank:
            return RDDSKitAsset.Images.backgroundWhite.image
        }
    }

    var sizeLCard: UIImage {
        switch self {
        case .joy:
            return RDDSKitAsset.Images.cardLYellow.image
        case .sad:
            return RDDSKitAsset.Images.cardLBlue.image
        case .scary:
            return RDDSKitAsset.Images.cardLRed.image
        case .strange:
            return RDDSKitAsset.Images.cardLPurple.image
        case .shy:
            return RDDSKitAsset.Images.cardLPink.image
        case .blank:
            return RDDSKitAsset.Images.cardLWhite.image
        }
    }

    var sizeMCard: UIImage {
        switch self {
        case .joy:
            return RDDSKitAsset.Images.cardMYellow.image
        case .sad:
            return RDDSKitAsset.Images.cardMBlue.image
        case .scary:
            return RDDSKitAsset.Images.cardMRed.image
        case .strange:
            return RDDSKitAsset.Images.cardMPurple.image
        case .shy:
            return RDDSKitAsset.Images.cardMPink.image
        case .blank:
            return RDDSKitAsset.Images.cardMWhite.image
        }
    }

    var sizeSCard: UIImage {
        switch self {
        case .joy:
            return RDDSKitAsset.Images.cardSYellow.image
        case .sad:
            return RDDSKitAsset.Images.cardSBlue.image
        case .scary:
            return RDDSKitAsset.Images.cardSRed.image
        case .strange:
            return RDDSKitAsset.Images.cardSPurple.image
        case .shy:
            return RDDSKitAsset.Images.cardSPink.image
        case .blank:
            return RDDSKitAsset.Images.cardSWhite.image
        }
    }

    var feelingLSizeImage: UIImage {
        switch self {
        case .joy:
            return RDDSKitAsset.Images.feelingLJoy.image
        case .sad:
            return RDDSKitAsset.Images.feelingLSad.image
        case .scary:
            return RDDSKitAsset.Images.feelingLScary.image
        case .strange:
            return RDDSKitAsset.Images.feelingLStrange.image
        case .shy:
            return RDDSKitAsset.Images.feelingLShy.image
        case .blank:
            return RDDSKitAsset.Images.feelingLBlank.image
        }
    }

    var feelingMSizeImage: UIImage {
        switch self {
        case .joy:
            return RDDSKitAsset.Images.feelingMJoy.image
        case .sad:
            return RDDSKitAsset.Images.feelingMSad.image
        case .scary:
            return RDDSKitAsset.Images.feelingMScary.image
        case .strange:
            return RDDSKitAsset.Images.feelingMStrange.image
        case .shy:
            return RDDSKitAsset.Images.feelingMShy.image
        case .blank:
            return RDDSKitAsset.Images.feelingMBlank.image
        }
    }
}
