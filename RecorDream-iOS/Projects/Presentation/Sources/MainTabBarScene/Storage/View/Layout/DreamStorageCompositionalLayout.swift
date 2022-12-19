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
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let filterHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(60))
            let filterHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: filterHeaderSize, elementKind: DreamWriteHeader.className, alignment: .top)
            let recordsHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let recordsHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: filterHeaderSize, elementKind: StorageHeaderCVC.className, alignment: .top)

            switch DreamStorageSection.type(sectionIndex) {
            case .filters:
                return self.createFilterSection(filterHeader)
            case .records:
                return self.createRecordsSection(recordsHeader)
            }
        }
    }
    
    private func createFilterSection(_ header: NSCollectionLayoutBoundarySupplementaryItem) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(32), heightDimension: .estimated(32))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(UIScreen.main.bounds.width), heightDimension: .absolute(53.adjusted))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 7)
        group.interItemSpacing = .fixed(30)
        group.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 20, leading: 0, bottom: 20, trailing: 0)
        return section
    }
    
    private func createRecordsSection(_ header: NSCollectionLayoutBoundarySupplementaryItem) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(470))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(511))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 0, leading: 19, bottom: 9, trailing: 19)
        return section
    }
}
