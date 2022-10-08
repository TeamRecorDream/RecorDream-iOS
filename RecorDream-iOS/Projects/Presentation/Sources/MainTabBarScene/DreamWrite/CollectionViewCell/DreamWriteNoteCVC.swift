//
//  DreamWriteNoteCVC.swift
//  Presentation
//
//  Created by Junho Lee on 2022/10/06.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_Core
import RD_DSKit

import RxSwift
import RxCocoa

final class DreamWriteNoteCVC: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties
    
    static var isFromNib: Bool = false
    
    // MARK: - UI Components
    
    private let noteTextView = DreamWriteTextView()
        .placeHolder("꿈에 대해 따로 기록할 게 있나요?")
    
    // MARK: - View Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DreamWriteNoteCVC {
    private func setUI() {
        self.backgroundColor = RDDSKitAsset.Colors.dark.color
    }
    
    private func setLayout() {
        self.addSubviews(noteTextView)
        
        noteTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(240)
            make.bottom.equalToSuperview().inset(78)
        }
    }
}
