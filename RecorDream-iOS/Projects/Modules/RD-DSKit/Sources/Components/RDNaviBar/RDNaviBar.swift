//
//  RDNaviBar.swift
//  RD-DSKit
//
//  Created by Junho Lee on 2022/10/06.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_Core

import RxSwift
import RxCocoa
import SnapKit

public class RDNaviBar: UIView {
    
    // MARK: - Properties
    
    public var leftButtonTapped: ControlEvent<Void> {
        return leftButton.rx.tap
    }
    
    // MARK: - UI Components
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 16)
        
        return label
    }()
    
    private let leftButton: UIButton = {
        let bt = UIButton()
        bt.setImage(RDDSKitAsset.Images.icnClose.image, for: .normal)
        bt.setImage(RDDSKitAsset.Images.icnClose.image, for: .selected)
        return bt
    }()
    
    private let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.1)
        return view
    }()
    
    // MARK: - Life Cycles
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        setUI()
        setLayout()
    }
    
    // MARK: - Methods
    
    private func setUI() {
        self.backgroundColor = RDDSKitAsset.Colors.dark.color
    }
    
    private func setLayout() {
        self.addSubviews(leftButton, titleLabel, bottomLine)
        
        leftButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.leading.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        bottomLine.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    @discardableResult
    public func title(_ title: String) -> Self {
        titleLabel.text = title
        
        return self
    }
    
    @discardableResult
    public func titleColor(_ color: UIColor) -> Self {
        self.titleLabel.textColor = color
        
        return self
    }

    @discardableResult
    public func font(_ font: UIFont) -> Self {
        self.titleLabel.font = font
        
        return self
    }
    
    @discardableResult
    public func backgroundColor(_ color: UIColor) -> Self {
        self.backgroundColor = color
        
        return self
    }
    
    @discardableResult
    public func leftButtonImage(_ image: UIImage) -> Self {
        self.leftButton.setImage(image, for: .normal)
        
        return self
    }
}
