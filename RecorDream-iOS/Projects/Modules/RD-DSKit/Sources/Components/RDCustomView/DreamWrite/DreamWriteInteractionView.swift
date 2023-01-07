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
        case voiceRecord(isEnabled: Bool, voiceExist: Bool)
    }
    
    public var viewType = InteractionType.date
    
    private var enabledColor = UIColor.white
    private var disabledColor = UIColor.white.withAlphaComponent(0.4)
    
    public var isEnabled = true
    
    public var voiceExist: Bool {
        return !(self.dataLabel.text == "00:00")
    }
    
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
        self.viewType = type
        switch type {
        case .date:
            self.iconImageView.image = RDDSKitAsset.Images.icnCalendar.image
            self.titleLabel.text = "날짜"
            let currentDate = {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                return formatter.string(from: Date())
            }()
            self.dataLabel.text = currentDate
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
        self.isEnabled = isEnabled
        
        let micImage = isEnabled
        ? RDDSKitAsset.Images.icnMicS.image
        : RDDSKitAsset.Images.icnMic.image
        iconImageView.image = micImage
        
        titleLabel.textColor = isEnabled ? enabledColor : disabledColor
        dataLabel.textColor = isEnabled ? enabledColor : disabledColor
        
        let recordImage = isEnabled
        ? RDDSKitAsset.Images.icnRdVoice.image
        : RDDSKitAsset.Images.icnRdVoiceDisabled.image
        buttonImageView.image = recordImage
    }
    
    public func updateDataLabel(data: String) {
        self.dataLabel.text = data
    }
    
    public func updateRecordLabel(record: CGFloat) {
        let totalTimeText = {
            let intTime = Int(record)
            return String(format: "%02d:%02d", intTime.miniuteDigitInt, intTime.secondsDigitInt)
        }()
        self.dataLabel.text = totalTimeText
    }
}

extension Reactive where Base: DreamWriteInteractionView {
    public var isInteractionEnabled: Binder<Bool> {
        return Binder(base) { view, isEnabled in
            view.updateEnabledStatus(isEnabled)
        }
    }
    
    public var recordTimeUpdated: Binder<CGFloat> {
        return Binder(base) { view, recordTime in
            view.updateRecordLabel(record: recordTime)
        }
    }
    
    public var dateUpdated: Binder<String> {
        return Binder(base) { view, date in
            view.updateDataLabel(data: date)
        }
    }
}
