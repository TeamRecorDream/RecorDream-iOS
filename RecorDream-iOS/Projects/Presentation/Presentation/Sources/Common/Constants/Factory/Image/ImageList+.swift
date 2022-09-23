//
//  ImageList+.swift
//  Presentation
//
//  Created by 정은희 on 2022/09/23.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

extension ImageList {
    var image: UIImage {
        guard let image = UIImage(named: self.name) else { return UIImage() }
        return image
    }
}
