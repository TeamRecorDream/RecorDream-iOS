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
            
            switch DreamSearchResultType.type(sectionNumber) {
            case .exist:
                return self.createExistSection()
            case .non:
                return self.createNoneSection()
            }
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
        let sectionFooter = self.createSectionFooter()
        section.orthogonalScrollingBehavior = .none
        section.boundarySupplementaryItems = [sectionHeader, sectionFooter]
        section.contentInsets = .init(
            top: 20, leading: 20, bottom: 0, trailing: 21
        )
        section.interGroupSpacing = 8
        return section
    }
    private func createNoneSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(1.0)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize, subitems: [item]
        )
        let sectionFooter = self.createSectionFooter()
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.boundarySupplementaryItems = [sectionFooter]
        section.contentInsets = .init(
            top: 208, leading: 113, bottom: 282, trailing: 113
        )
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
    private func createSectionFooter() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(152.adjustedHeight))
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: layoutSectionFooterSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
        sectionFooter.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
        return sectionFooter
    }
}

