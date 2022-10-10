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

public class DreamWritePlayerSliderView: UIView {
    
    // MARK: - Properties
    
    var elapsedTimeSecondsFloat: Float64 = 0 {
        didSet {
            guard self.elapsedTimeSecondsFloat != oldValue else { return }
            let elapsedSecondsInt = Int(self.elapsedTimeSecondsFloat)
            let elapsedTimeText = String(format: "%02d:%02d", elapsedSecondsInt.miniuteDigitInt, elapsedSecondsInt.secondsDigitInt)
            self.currentTimeLabel.text = elapsedTimeText
            self.progressValue = self.elapsedTimeSecondsFloat / self.totalTimeSecondsFloat
        }
    }
    
    var totalTimeSecondsFloat: Float64 = 180
    
    var progressValue: Float64? {
        didSet { self.playSlider.value = Float(self.elapsedTimeSecondsFloat / self.totalTimeSecondsFloat) }
    }
    
    // MARK: - UI Components
    
    private let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = RDDSKitFontFamily.Pretendard.medium.font(size: 14)
        label.textColor = .white
        return label
    }()
    
    private lazy var playSlider: DreamWriteSlider = {
        let slider = DreamWriteSlider()
        slider.tintColor = RDDSKitAsset.Colors.purple.color
        slider.maximumTrackTintColor = RDDSKitAsset.Colors.dark.color
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.setThumbImage(UIImage(), for: .normal)
        slider.isUserInteractionEnabled = false
        return slider
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
            make.trailing.equalTo(playSlider.snp.leading).offset(-11.adjusted)
        }
        
        playSlider.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(15.adjustedH)
            make.width.equalTo(228.adjusted)
        }
        
        totalTimeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(playSlider.snp.trailing).offset(11.adjusted)
        }
    }
}
