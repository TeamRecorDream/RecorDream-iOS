//
//  RDCollectionViewFlowLayout.swift
//  Presentation
//
//  Created by 정은희 on 2022/12/08.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

public class RDCollectionViewFlowLayout: UICollectionViewFlowLayout {
    // MARK: - Properties
    public enum CollectionDisplay: String {
        case grid
        case list
    }
    public var display: CollectionDisplay = .grid {
        didSet {
            if display != oldValue {
                self.invalidateLayout()
            }
        }
    }
    // MARK: - Initialization
    convenience init(display: CollectionDisplay) {
        self.init()
        
        self.setupView(display)
        self.setupLayout(display)
    }
}

// MARK: - Extensions
extension RDCollectionViewFlowLayout {
    private func setupView(_ display: CollectionDisplay) {
        self.display = display
        self.minimumLineSpacing = 9.adjusted
        self.minimumInteritemSpacing = 9.adjusted
        self.scrollDirection = .vertical
    }
    private func setupLayout(_ display: CollectionDisplay) {
        switch display {
        case .list:
            if let collectionView = self.collectionView {
                self.itemSize = CGSize(width: collectionView.frame.width, height: 88)
            }
        case .grid:
            if let collectionView = self.collectionView {
                let optimisedWidth = (collectionView.frame.width - minimumInteritemSpacing) / 2.adjusted
                self.itemSize = CGSize(width: optimisedWidth, height: optimisedWidth * 2.adjusted)
            }
        }
    }
    public override func invalidateLayout() {
        super.invalidateLayout()
        self.setupLayout(display)
    }
}
