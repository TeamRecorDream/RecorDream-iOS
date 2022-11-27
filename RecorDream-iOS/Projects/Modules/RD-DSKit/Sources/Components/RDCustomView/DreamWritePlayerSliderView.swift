//
//  DreamWritePlayerSlider.swift
//  RD-DSKit
//
//  Created by Junho Lee on 2022/10/11.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_Core

import SnapKit
import RxSwift
import RxCocoa

public class DreamWritePlayerSliderView: UIView {
    
    // MARK: - Properties
    
    var elapsedTimeSecondsFloat: Float64 = 0 {
        didSet {
            guard self.elapsedTimeSecondsFloat != oldValue else { return }
            let elapsedSecondsInt = Int(self.elapsedTimeSecondsFloat)
            let elapsedTimeText = String(format: "%02d:%02d", elapsedSecondsInt.miniuteDigitInt, elapsedSecondsInt.secondsDigitInt)
            self.currentTimeLabel.text = elapsedTimeText
            self.playSlider.setProgress(Float(self.elapsedTimeSecondsFloat / self.totalTimeSecondsFloat), animated: false)
        }
    }
    
    var totalTimeSecondsFloat: Float64 = 180 {
        didSet {
            let totalTimeText = {
                let minute = Int(totalTimeSecondsFloat)
                let seconds = Int(totalTimeSecondsFloat)
                return String(format: "%02d:%02d", minute.miniuteDigitInt, seconds.secondsDigitInt)
            }()
            self.totalTimeLabel.text = totalTimeText
        }
    }
    
    // MARK: - UI Components
    
    private let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = RDDSKitFontFamily.Pretendard.medium.font(size: 14)
        label.textColor = .white
        return label
    }()
    
    private lazy var playSlider: UIProgressView = {
        let pg = UIProgressView()
        pg.tintColor = RDDSKitAsset.Colors.purple.color
        pg.trackTintColor = RDDSKitAsset.Colors.dark.color
        pg.translatesAutoresizingMaskIntoConstraints = false
        return pg
    }()
    
    private let totalTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "03:00"
        label.font = RDDSKitFontFamily.Pretendard.medium.font(size: 14)
        label.textColor = .white
        return label
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

extension DreamWritePlayerSliderView {
    private func setUI() {
        self.backgroundColor = RDDSKitAsset.Colors.grey01.color
        self.layer.cornerRadius = 16
    }
    
    private func setLayout() {
        self.addSubviews(currentTimeLabel, playSlider, totalTimeLabel)
        
        currentTimeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(24.adjusted)
        }
        
        playSlider.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(6.adjustedH)
            make.width.equalTo(228.adjusted)
        }
        
        totalTimeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(24.adjusted)
        }
    }
}

// MARK: - Methods

extension DreamWritePlayerSliderView {
    public func stopRecordAndHiddenLabel() {
        self.totalTimeSecondsFloat = self.elapsedTimeSecondsFloat
        self.elapsedTimeSecondsFloat = 0
        self.elapsedTimeSecondsFloat = totalTimeSecondsFloat
        self.currentTimeLabel.isHidden = true
    }
    
    public func resetSliderView() {
        self.currentTimeLabel.isHidden = false
        self.totalTimeSecondsFloat = 180.0
        self.elapsedTimeSecondsFloat = 0.0
    }
}

// MARK: - Reactive Extension

extension Reactive where Base: DreamWritePlayerSliderView {
    public var elapsedTime: Binder<Double> {
        return Binder(base) { view, elapsedTime in
            view.elapsedTimeSecondsFloat = elapsedTime
        }
    }
}
