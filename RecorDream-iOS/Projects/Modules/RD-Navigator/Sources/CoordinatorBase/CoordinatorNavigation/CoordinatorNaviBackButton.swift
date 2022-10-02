//
//  CoordinatorNaviBackButton.swift
//  RouterCoordinator
//
//  Created by Junho Lee on 2022/09/29.
//

import UIKit


/// CoordinatorNavigationControoler에 사용되는 CoordinatorNaviBackButton입니다.
class CoordinatorNaviBackButton: UIButton {
    
    static func initCustomBackButton(backButtonImage: UIImage? = nil, backButtonTitle: String? = nil, backButtonfont: UIFont? = nil, backButtonTitleColor: UIColor? = nil) -> UIButton {
        let button = UIButton(type: .system)
        if let backButtonImage = backButtonImage {
            button.setImage(backButtonImage, for: .normal)
        }
        if let backButtonTitle = backButtonTitle {
            button.setTitle(backButtonTitle, for: .normal)
        }
        if let backButtonfont = backButtonfont {
            button.titleLabel?.font = backButtonfont
        }
        if let backButtonTitleColor = backButtonTitleColor {
            button.setTitleColor(backButtonTitleColor, for: .normal)
        }
        
        centerTextAndImage(at: button, spacing: 8)
        
        return button
    }
    
    static func centerTextAndImage(at btn: UIButton, spacing: CGFloat) {
        let insetAmount = spacing / 2
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
}
