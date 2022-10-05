//
//  UICollectionViewRegisterable.swift
//
//  Created by Junho Lee on 2022/09/24.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

public protocol UICollectionViewRegisterable {
    static var isFromNib: Bool { get }
    static func register(target: UICollectionView)
}

public extension UICollectionViewRegisterable where Self: UICollectionViewCell {
    static func register(target: UICollectionView) {
        if self.isFromNib {
          target.register(UINib(nibName: Self.className, bundle: nil), forCellWithReuseIdentifier: Self.className)
        } else {
          target.register(Self.self, forCellWithReuseIdentifier: Self.className)
        }
    }
}

public protocol UICollectionReusableViewRegisterable {
    static var isFromNib: Bool { get }
    static func register(target: UICollectionView)
}

public extension UICollectionReusableViewRegisterable where Self: UICollectionReusableView {
    static func register(target: UICollectionView) {
        if self.isFromNib {
            target.register(UINib(nibName: Self.className, bundle: nil), forSupplementaryViewOfKind: Self.className, withReuseIdentifier: Self.className)
        } else {
            target.register(Self.self, forSupplementaryViewOfKind: Self.className, withReuseIdentifier: Self.className)
        }
    }
}
