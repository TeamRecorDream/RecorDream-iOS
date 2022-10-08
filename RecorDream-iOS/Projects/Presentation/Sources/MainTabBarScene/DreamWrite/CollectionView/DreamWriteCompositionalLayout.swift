//
//  DreamWriteCompositionalLayout.swift
//  Presentation
//
//  Created by Junho Lee on 2022/10/05.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_Core
import RD_DSKit

extension DreamWriteVC {
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .estimated(44))
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: DreamWriteHeader.className, alignment: .top)
            
            let labelItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(24))
            let bottomLabelItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: labelItemSize, elementKind: DreamWriteWarningFooter.className, alignment: .bottom)
            
            let lineItemHeight: CGFloat = 26
            let lineItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .absolute(lineItemHeight))
            let bottomLineItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: lineItemSize, elementKind: DreamWriteDividerView.className, alignment: .bottom)
            
            switch Section.type(sectionIndex) {
            case .main: return self.createMainSection()
            case .emotions: return self.createEmotionSection(headerItem, bottomLineItem)
            case .genres: return self.createGenreSection(headerItem,  bottomLabelItem)
            case .note: return self.createNoteSection(headerItem)
            }
        }
    }
    
    private func createMainSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(315))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(315))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        return section
    }
    
    private func createEmotionSection(_ header: NSCollectionLayoutBoundarySupplementaryItem, _ footer: NSCollectionLayoutBoundarySupplementaryItem) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(32/375), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(UIScreen.main.bounds.width), heightDimension: .absolute(52.adjusted))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 5)
        group.interItemSpacing = .fixed(40)
        group.contentInsets = .init(top: 0, leading: 28, bottom: 0, trailing: 28)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header, footer]
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 18, leading: 0, bottom: 14, trailing: 0)
        return section
    }
    
    private func createGenreSection(_ header: NSCollectionLayoutBoundarySupplementaryItem, _ footer: NSCollectionLayoutBoundarySupplementaryItem) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(60), heightDimension: .absolute(30))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(UIScreen.main.bounds.height * 52 / 812))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(12)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header, footer]
        section.orthogonalScrollingBehavior = .none
        section.interGroupSpacing = 12
        header.contentInsets = .init(top: 0, leading: -24, bottom: 0, trailing: 0)
        section.contentInsets = .init(top: 18, leading: 25, bottom: 9, trailing: 25)
        footer.contentInsets = .init(top: 0, leading: -1, bottom: 0, trailing: 0)
        return section
    }
    
    private func createNoteSection(_ header: NSCollectionLayoutBoundarySupplementaryItem) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(315))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(315))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 18, leading: 0, bottom: 88, trailing: 0)
        return section
    }
}
