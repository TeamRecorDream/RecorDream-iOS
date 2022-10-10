//
//  DreamWriteRecordView.swift
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

public class DreamWriteRecordView: UIView {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    // MARK: - UI Components
    
    private let grabberView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.4)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "음성녹음"
        label.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 16)
        label.textColor = .white
        label.sizeToFit()
        return label
    }()
    
    private let mainMicImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = RDDSKitAsset.Images.icnMicTitle.image
        return iv
    }()
    
    private let playSliderView = DreamWritePlayerSliderView()
    
    private let recordButton: UIButton = {
        let bt = UIButton()
        bt.setImage(RDDSKitAsset.Images.icnMicStart.image, for: .normal)
        return bt
    }()
    
    private let closeButton: UIButton = {
        let bt = UIButton()
        bt.setImage(RDDSKitAsset.Images.icnMicCancel.image, for: .normal)
        bt.isHidden = true
        return bt
    }()
    
    private let saveButton: UIButton = {
        let bt = UIButton()
        bt.setImage(RDDSKitAsset.Images.icnMicSave.image, for: .normal)
        bt.isHidden = true
        return bt
    }()
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI & Layouts

extension DreamWriteRecordView {
    private func setUI() {
        self.backgroundColor = RDDSKitAsset.Colors.grey01.color
        self.layer.cornerRadius = 16
    }
    
    private func setLayout() {
        self.addSubviews(grabberView, titleLabel, mainMicImageView,
                         playSliderView, recordButton, closeButton,
                         saveButton)
        
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
        
        mainMicImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24.adjustedH)
            make.width.height.equalTo(72.adjustedH)
            make.centerX.equalToSuperview()
        }
        
        playSliderView.snp.makeConstraints { make in
            make.top.equalTo(mainMicImageView.snp.bottom).offset(21.adjustedH)
            make.height.equalTo(23.adjustedH)
            make.centerX.equalToSuperview()
        }
        
        playSliderView.elapsedTimeSecondsFloat = 130
        
        recordButton.snp.makeConstraints { make in
            make.top.equalTo(playSliderView.snp.bottom).offset(36.adjustedH)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(54.adjusted)
        }
        
        closeButton.snp.makeConstraints { make in
            make.centerY.equalTo(recordButton.snp.centerY)
            make.width.height.equalTo(54.adjusted)
            make.leading.equalToSuperview().inset(23.adjusted)
        }
        
        saveButton.snp.makeConstraints { make in
            make.centerY.equalTo(recordButton.snp.centerY)
            make.width.height.equalTo(54.adjusted)
            make.trailing.equalToSuperview().inset(23.adjusted)
        }
    }
}
