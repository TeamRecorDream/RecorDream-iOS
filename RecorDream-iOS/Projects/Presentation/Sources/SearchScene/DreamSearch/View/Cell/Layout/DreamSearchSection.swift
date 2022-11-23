//
//  DreamSearchSection.swift
//  Presentation
//
//  Created by 정은희 on 2022/10/16.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit


extension DreamSearchVC {
    func layout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionNumber, environment -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }

//            switch DreamSearchResultType {
//            case .exist:
//                self.createExistSection()
//            case .non:
//                self.createNoneSection()
//            }
            return self.createNoneSection()

        }
    }
    private func createExistSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(88.adjustedHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(88.adjustedHeight)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let sectionFooter = self.createSectionFooter()
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [sectionFooter]
        section.contentInsets = .init(
            top: 20, leading: 18, bottom: 20, trailing: 18
        )
        return section
    }
    private func createNoneSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
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
    private func createSectionFooter() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(17.adjustedHeight))
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: layoutSectionFooterSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
        return sectionFooter
    }
}

