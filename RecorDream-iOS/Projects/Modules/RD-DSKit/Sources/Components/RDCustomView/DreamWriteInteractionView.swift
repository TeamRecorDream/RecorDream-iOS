//
//  DreamWriteInteractionView.swift
//  RD-DSKit
//
//  Created by Junho Lee on 2022/10/08.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

public class DreamWriteInteractionView: UIView {
    
    // MARK: - Properties
    
    public enum InteractionType {
        case date
        case voiceRecord
    }
    
    private var enabledColor = UIColor.white
    private var disabledColor = UIColor.white.withAlphaComponent(0.4)
    
    // MARK: - UI Components
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage()
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = RDDSKitFontFamily.Pretendard.medium.font(size: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private let dataLabel: UILabel = {
        let label = UILabel()
        label.font = RDDSKitFontFamily.Pretendard.medium.font(size: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private let buttonImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage()
        return iv
    }()
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI & Layouts

extension DreamWriteInteractionView {
    private func setUI() {
        self.backgroundColor = .white.withAlphaComponent(0.05)
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
    }
    
    private func setLayout() {
        self.addSubviews(iconImageView, titleLabel, dataLabel,
                         buttonImageView)
        
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24.adjusted)
            make.leading.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing).offset(8)
        }
        
        dataLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(buttonImageView.snp.leading).offset(-8)
        }
        
        buttonImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
            make.width.height.equalTo(14)
        }
    }
}

// MARK: - Methods

extension DreamWriteInteractionView {
    @discardableResult
    public func viewType(_ type: InteractionType) -> Self {
        switch type {
        case .date:
            self.iconImageView.image = RDDSKitAsset.Images.icnCalendar.image
            self.titleLabel.text = "날짜"
            self.dataLabel.text = "2022-06-27"
            self.buttonImageView.image = RDDSKitAsset.Images.icnArrow.image
        case .voiceRecord:
            self.iconImageView.image = RDDSKitAsset.Images.icnMicS.image
            self.titleLabel.text = "음성녹음"
            self.dataLabel.text = "00:00"
            self.buttonImageView.image = RDDSKitAsset.Images.icnRdVoice.image
        }
        return self
    }
    
    public func updateEnabledStatus(_ isEnabled: Bool) {
        let micImage = isEnabled
        ? RDDSKitAsset.Images.icnMicS.image
        : RDDSKitAsset.Images.icnMic.image
        iconImageView.image = micImage
        
        titleLabel.textColor = isEnabled ? enabledColor : disabledColor
        dataLabel.textColor = isEnabled ? enabledColor : disabledColor
        
        let recordImage = isEnabled
        ? RDDSKitAsset.Images.icnRdVoiceS.image
        : RDDSKitAsset.Images.icnRdVoice.image
        buttonImageView.image = recordImage
    }
}

extension Reactive where Base: DreamWriteInteractionView {
    public var isInteractionEnabled: Binder<Bool> {
        return Binder(base) { view, isEnabled in
            view.updateEnabledStatus(isEnabled)
        }
    }
}
