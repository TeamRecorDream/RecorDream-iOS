//
//  ColorType+.swift
//  Presentation
//
//  Created by 정은희 on 2022/09/23.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

public extension ColorType {
    var color: UIColor {
        guard let color = UIColor(named: self.name) else { return UIColor() }
        return color
    }
}
