//
//  DreamWriteSlider.swift
//  RD-DSKit
//
//  Created by Junho Lee on 2022/10/11.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

public class DreamWriteSlider: UISlider {
    public override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var newBounds = super.trackRect(forBounds: bounds)
        newBounds.size.height = 6.adjusted
        return newBounds
    }
}
