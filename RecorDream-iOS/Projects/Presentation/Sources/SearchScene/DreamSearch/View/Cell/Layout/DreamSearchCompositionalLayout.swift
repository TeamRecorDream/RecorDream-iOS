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
            
            let resultHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(38))
            let resultHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: resultHeaderSize, elementKind: DreamSearchHeaderCVC.className, alignment: .top)

            switch DreamSearchResultType.type(sectionNumber) {
            case .exist:
                return self.createExistSection(resultHeader)
            case .non:
                return self.createNoneSection()
            }
        }
    }
    private func createExistSection(_ header: NSCollectionLayoutBoundarySupplementaryItem) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(400.adjustedHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(400.adjustedHeight)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let sectionFooter = self.createSectionFooter()
        section.orthogonalScrollingBehavior = .none
        section.boundarySupplementaryItems = [sectionFooter]
        section.contentInsets = .init(
            top: 8, leading: 20, bottom: 0, trailing: 21
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
        let layoutSectionFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(152.adjustedHeight))
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: layoutSectionFooterSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
        sectionFooter.contentInsets = .init(top: 0, leading: 0, bottom: 54, trailing: 0)
        return sectionFooter
    }
}

