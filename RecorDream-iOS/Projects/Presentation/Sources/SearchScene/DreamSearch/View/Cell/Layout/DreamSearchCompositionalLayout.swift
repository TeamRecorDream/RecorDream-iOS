//
//  DreamSearchCompositionalLayout.swift
//  Presentation
//
//  Created by 정은희 on 2022/10/16.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

extension DreamSearchVC {
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionNumber, environment -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            return self.createExistSection()
        }
    }
    private func createExistSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(88.adjustedHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(88.adjustedHeight)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let sectionHeader = self.createSectionHeader()
        section.orthogonalScrollingBehavior = .none
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = .init(
            top: 20, leading: 20, bottom: 0, trailing: 21
        )
        section.interGroupSpacing = 8
        return section
    }
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(152.adjustedHeight))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: layoutSectionHeaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        sectionHeader.contentInsets = .init(top: 20, leading: 0, bottom: 12, trailing: 18)
        return sectionHeader
    }
}

