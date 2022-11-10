//
//  RDDateTimePickerView.swift
//  RD-DSKit
//
//  Created by Junho Lee on 2022/11/03.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_Core

import SnapKit
import RxSwift
import RxCocoa

public class RDDateTimePickerView: UIView {
    
    // MARK: - Properties
    
    public enum viewType {
        case date
        case time
    }
    
    // MARK: - UI Components
    
    private let grabberView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.4)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "날짜 설정"
        label.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 16)
        label.textColor = .white
        label.sizeToFit()
        return label
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.tintColor = .white
        return datePicker
    }()
    
    private let timePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.tintColor = .white
        return timePicker
    }()
    
    public let cancelButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("취소", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.titleLabel?.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 16)
        bt.backgroundColor = RDDSKitAsset.Colors.white01.color.withAlphaComponent(0.1)
        bt.layer.cornerRadius = 10
        return bt
    }()
    
    public let saveButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("저장", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.titleLabel?.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 16)
        bt.backgroundColor = RDDSKitAsset.Colors.purple.color
        bt.layer.cornerRadius = 10
        return bt
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

extension RDDateTimePickerView {
    private func setUI() {
        self.backgroundColor = RDDSKitAsset.Colors.grey01.color
        self.layer.cornerRadius = 16
    }
    
    private func setLayout() {
        self.addSubviews(grabberView, titleLabel, datePicker,
                         timePicker, cancelButton, saveButton)
        
        grabberView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12.adjustedH)
            make.width.equalTo(38.adjusted)
            make.height.equalTo(3.adjustedH)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(grabberView.snp.bottom).offset(14.adjustedH)
            make.centerX.equalToSuperview()
        }
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(56)
        }
        
        timePicker.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(56)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(54.adjustedH)
            make.height.equalTo(40.adjustedH)
            make.width.equalTo(140.adjusted)
            make.leading.equalToSuperview().inset(26.adjusted)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(54.adjustedH)
            make.height.equalTo(40.adjustedH)
            make.width.equalTo(140.adjusted)
            make.trailing.equalToSuperview().inset(26.adjusted)
        }
    }
}

// MARK: - Methods

extension RDDateTimePickerView {
    @discardableResult
    public func viewType(_ type: viewType) -> Self {
        switch type {
        case .date:
            self.titleLabel.text = "날짜 설정"
            timePicker.removeFromSuperview()
        case .time:
            self.titleLabel.text = "시간 설정"
            datePicker.removeFromSuperview()
        }
        return self
    }
}

extension Reactive where Base: RDDateTimePickerView {
    public var cancelButtonTapped: ControlEvent<Void> {
        return base.cancelButton.rx.tap
    }
    
    public var saveButtonTapped: ControlEvent<Void> {
        return base.saveButton.rx.tap
    }
}
