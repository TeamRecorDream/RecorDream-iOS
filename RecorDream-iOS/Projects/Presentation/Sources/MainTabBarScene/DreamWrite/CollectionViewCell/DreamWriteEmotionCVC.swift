//
//  DreamWriteEmojiCVC.swift
//  Presentation
//
//  Created by Junho Lee on 2022/10/06.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_Core
import RD_DSKit

import RxRelay

final class DreamWriteEmotionCVC: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties
    
    static var isFromNib: Bool = false
    
    override var isSelected: Bool {
        didSet { self.updateUI() }
    }
    
    private let selectedColor = UIColor.white
    private let deselectedColor = UIColor.white.withAlphaComponent(0.4)
    
    private var selectedImage = UIImage()
    private var deselectedImage = UIImage()
    
    // MARK: - UI Components
    
    private let emotionImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = RDDSKitAsset.Images.feelingXsSad.image
        return iv
    }()
    
    private lazy var emotionLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        lb.textColor = UIColor.white.withAlphaComponent(0.4)
        lb.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 10.adjusted)
        return lb
    }()
    
    // MARK: - Reactive Stuff
    var emotionImageViewTapped = PublishRelay<DreamStorageSection>()
    
    // MARK: - View Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setLayout()
        self.setGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DreamWriteEmotionCVC {
    private func setLayout() {
        self.addSubviews(emotionImageView, emotionLabel)
        
        emotionImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.width.height.equalTo(32)
        }
        
        emotionLabel.snp.makeConstraints { make in
            make.top.equalTo(emotionImageView.snp.bottom).offset(7)
            make.centerX.equalToSuperview()
            make.height.equalTo(15)
        }
    }
    
    private func updateUI() {
        emotionLabel.textColor = isSelected
        ? selectedColor
        : deselectedColor
        
        emotionImageView.image = isSelected
        ? selectedImage
        : deselectedImage
    }
    
    func setData(selectedImage: UIImage, deselectedImage: UIImage, text: String) {
        emotionImageView.image = deselectedImage
        emotionLabel.text = text
        emotionLabel.sizeToFit()
        
        self.selectedImage = selectedImage
        self.deselectedImage = deselectedImage
    }
}

// MARK: - Methods
extension DreamWriteEmotionCVC {
    private func setGesture() {
        let emotionImageViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(filterButtonTapped))
        self.emotionImageView.addGestureRecognizer(emotionImageViewTapGesture)
    }
    @objc
    private func filterButtonTapped(_ sender: UITapGestureRecognizer) {
        if self.isSelected {
            self.emotionImageViewTapped.accept(.filters)
        }
    }
}
