//
//  ShowToast.swift
//
//  Created by Junho Lee on 2022/09/24.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit
import SnapKit

public extension UIViewController {
    func showToast(message: String) {
        Toast.show(message: message, controller: self)
    }
}

public class Toast {
    static func show(message: String, controller: UIViewController) {
        
        let toastContainer = UIView()
        let toastLabel = UILabel()
        
        toastContainer.backgroundColor = RDDSKitAsset.Colors.white01.color
        toastContainer.alpha = 1
        toastContainer.layer.cornerRadius = 10
        toastContainer.clipsToBounds = true
        toastContainer.isUserInteractionEnabled = false
        
        toastLabel.textColor = RDDSKitAsset.Colors.grey02.color
        toastLabel.textAlignment = .center
        toastLabel.font = RDDSKitFontFamily.Pretendard.medium.font(size: 14)
        toastLabel.text = message
        toastLabel.clipsToBounds = true
        toastLabel.numberOfLines = 0
        toastLabel.sizeToFit()
        
        toastContainer.addSubview(toastLabel)
        controller.view.addSubview(toastContainer)
        
        toastContainer.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(controller.safeAreaBottomInset()+94)
            $0.width.equalTo(250)
            $0.height.equalTo(46)
        }
        
        toastLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseIn, animations: {
            toastContainer.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.4, delay: 1.0, options: .curveEaseOut, animations: {
                toastContainer.alpha = 0.0
            }, completion: {_ in
                toastContainer.removeFromSuperview()
            })
        })
    }
}
