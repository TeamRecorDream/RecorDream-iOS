//
//  DreamWriteSaveButton.swift
//  RD-DSKit
//
//  Created by Junho Lee on 2022/10/08.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

public class DreamWriteSaveButton: UIButton {
    
    // MARK: - Properties
    
    public override var isEnabled: Bool {
        didSet {
            self.updateEnabledStatus()
        }
    }
    
    private let enabledBackgroundColor = RDDSKitAsset.Colors.purple.color
    private let disabledBackgroundColor = RDDSKitAsset.Colors.grey01.color
    private let enabledTextColor = UIColor.white
    private let disabledTextColor = UIColor.white.withAlphaComponent(0.4)
    
    // MARK: - UI Components
    
    private lazy var customTitleLabel: UILabel = {
        let label = UILabel()
        label.font = RDDSKitFontFamily.Pretendard.bold.font(size: 16)
        label.textColor = disabledTextColor
        label.sizeToFit()
        return label
    }()
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI & Layouts

extension DreamWriteSaveButton {
    
    private func setUI() {
        self.backgroundColor = disabledBackgroundColor
        self.isEnabled = false
        self.titleLabel?.isHidden = true
    }
    
    private func setLayout() {
        self.addSubview(customTitleLabel)
        
        customTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: - Methods

extension DreamWriteSaveButton {
    
    private func updateEnabledStatus() {
        self.backgroundColor = isEnabled
        ? enabledBackgroundColor
        : disabledBackgroundColor
        
        self.customTitleLabel.textColor = isEnabled
        ? enabledTextColor
        : disabledTextColor
    }
    
    @discardableResult
    public func title(_ title: String) -> Self {
        self.customTitleLabel.text = title
        return self
    }
}
