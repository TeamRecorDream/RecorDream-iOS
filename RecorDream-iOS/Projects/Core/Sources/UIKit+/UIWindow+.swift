//
//  UIWindow+.swift
//  RD-Core
//
//  Created by Junho Lee on 2022/12/19.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

import UIKit

public extension UIWindow {
    static var keyWindowGetter: UIWindow? {
        if #available(iOS 13, *) {
            return (UIApplication.shared.connectedScenes
                        .compactMap { $0 as? UIWindowScene }
                        .flatMap { $0.windows }
                        .first { $0.isKeyWindow })
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
