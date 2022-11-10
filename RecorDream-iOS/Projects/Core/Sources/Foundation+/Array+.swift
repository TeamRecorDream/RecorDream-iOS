//
//  Array+.swift
//  RD-Core
//
//  Created by 김수연 on 2022/10/24.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

public extension Array {
  func safeget(index: Int) -> Element? {
    return index >= 0 && index < count ? self[index] : nil
  }
}
