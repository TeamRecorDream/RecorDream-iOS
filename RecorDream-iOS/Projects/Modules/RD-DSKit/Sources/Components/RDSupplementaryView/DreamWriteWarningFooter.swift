//
//  DreamWriteWarningFooter.swift
//  RD-DSKit
//
//  Created by Junho Lee on 2022/10/08.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_Core

public class DreamWriteWarningFooter: UICollectionReusableView, UICollectionReusableViewRegisterable {
    
    // MARK: - Properties
    
    public static var isFromNib: Bool = false
    
    // MARK: - UI Components
    
    private let warningLabel: UILabel = {
        let label = UILabel()
        label.font = RDDSKitFontFamily.Pretendard.light.font(size: 10)
        label.textColor = RDDSKitAsset.Colors.red.color
        label.text = "!꿈의 장르는 최대 3개까지만 선택할 수 있어요"
        label.sizeToFit()
        return label
    }()
    
    // MARK: - View Life Cycles
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: UI & Layout

extension DreamWriteWarningFooter {
    private func setLayout() {
        self.addSubviews(warningLabel)
        
        warningLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(9)
        }
    }
}
