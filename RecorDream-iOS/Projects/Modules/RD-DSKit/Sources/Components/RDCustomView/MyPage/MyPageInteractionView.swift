//
//  MyPageInteractionView.swift
//  RD-DSKit
//
//  Created by Junho Lee on 2022/10/09.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_Core

import SnapKit
import RxSwift
import RxCocoa

public class MyPageInteractionView: UIView {
    
    // MARK: - Properties
    
    public enum InteractionType {
        case pushOnOff
        case timeSetting
    }
    
    private var enabledColor = UIColor.white
    private var disabledColor = UIColor.white.withAlphaComponent(0.4)
    
    // MARK: - UI Components
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 16)
        label.textColor = .white
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    public let pushSwitch: UISwitch = {
        let sw = UISwitch()
        sw.onTintColor = RDDSKitAsset.Colors.purple.color
        sw.isSelected = false
        sw.thumbSize(scaleX: 0.6.adjusted, scaleY: 0.75.adjustedH)
        sw.totalSize(width: 51.adjusted, height: 24.adjustedH)
        sw.backgroundCornerRadius(cornerRadius: 13.adjusted)
        return sw
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = RDDSKitFontFamily.Pretendard.medium.font(size: 16)
        label.text = "AM 00:00"
        label.textColor = .white
        label.textAlignment = .center
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

extension MyPageInteractionView {
    private func setUI() {
        self.backgroundColor = .white.withAlphaComponent(0.1)
        self.clipsToBounds = true
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
    }
    
    private func setLayout() {
        self.addSubviews(titleLabel, pushSwitch, timeLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(22)
        }
        
        pushSwitch.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(22)
            make.width.equalTo(46.adjusted)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(22)
        }
    }
}

// MARK: - Methods

extension MyPageInteractionView {
    @discardableResult
    public func viewType(_ type: InteractionType) -> Self {
        switch type {
        case .pushOnOff:
            self.titleLabel.text = "꿈 푸시알림"
            self.pushSwitch.isHidden = false
            self.timeLabel.isHidden = true
        case .timeSetting:
            self.titleLabel.text = "시간 설정"
            self.pushSwitch.isHidden = true
            self.timeLabel.isHidden = false
            self.updateEnabledStatus(false)
        }
        return self
    }
    
    public func updateEnabledStatus(_ isEnabled: Bool) {
        titleLabel.textColor = isEnabled ? enabledColor : disabledColor
        
        timeLabel.textColor = isEnabled ? enabledColor : disabledColor
        timeLabel.text = isEnabled ? timeLabel.text : "AM 00:00"
        timeLabel.isHidden = !isEnabled
    }
    
    public func updatePushTime(pushTime: String?) {
        guard let time = pushTime else {
            self.updateEnabledStatus(false)
            return
        }
        self.updateEnabledStatus(true)
        self.timeLabel.text = time
    }
}

extension Reactive where Base: MyPageInteractionView {
    public var isInteractionEnabled: Binder<Bool> {
        return Binder(base) { view, isEnabled in
            view.updateEnabledStatus(isEnabled)
        }
    }
    
    public var pushTimeSelected: Binder<String?> {
        return Binder(base) { view, pushTime in
            view.updatePushTime(pushTime: pushTime)
        }
    }
    
    public var pushSwitchIsOnBindable: Binder<Bool> {
        return Binder(base) { view, isOn in
            view.pushSwitch.setOn(isOn, animated: true)
        }
    }
    
    public var pushSwitchIsOn: ControlProperty<Bool> {
        return base.pushSwitch.rx.isOn
    }
}
