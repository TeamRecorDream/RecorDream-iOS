//
//  DreamStorageCompositionalLayout.swift
//  Presentation
//
//  Created by 정은희 on 2022/12/08.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_DSKit

extension StorageVC {
    func createFilterLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let filterHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(60))
            let filterHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: filterHeaderSize, elementKind: DreamWriteHeader.className, alignment: .top)
            return self.createFilterSection(filterHeader)
        }
    }
    func createStorageLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            return self.currentLayoutType == .list
            ? self.createListRecordsSection()
            : self.createGridRecordsSection()
        }
    }
    
    // MARK: - Filter Section
    
    private func createFilterSection(_ header: NSCollectionLayoutBoundarySupplementaryItem) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(32.adjusted), heightDimension: .fractionalWidth(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(UIScreen.main.bounds.width), heightDimension: .absolute(53.adjusted))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 7)
        group.interItemSpacing = .fixed(30.adjusted)
        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 20, leading: 16, bottom: 20, trailing: 17)
        return section
    }
    
    // MARK: - Records Section
    
    private func createListRecordsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let header = self.createRecordHeader()
        header.pinToVisibleBounds = true
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 0, leading: 19, bottom: 9, trailing: 19)
        return section
    }
    
    private func createGridRecordsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(164.adjusted),
                                              heightDimension: .absolute(196.adjusted))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(UIScreen.main.bounds.width),
                                               heightDimension: .estimated(196.adjusted))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(9)
        let header = self.createRecordHeader()
        header.pinToVisibleBounds = true
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 9
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 0, leading: 19, bottom: 9, trailing: 19)
        return section
    }
    
    private func createRecordHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60.adjustedHeight))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: layoutSectionHeaderSize,
            elementKind: StorageHeaderCVC.className,
            alignment: .topLeading
        )
        return sectionHeader
    }
}
