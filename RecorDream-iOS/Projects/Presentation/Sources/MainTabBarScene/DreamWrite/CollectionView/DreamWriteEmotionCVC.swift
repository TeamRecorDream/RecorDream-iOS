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

final class DreamWriteEmotionCVC: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties
    
    static var isFromNib: Bool = false
    
    // MARK: - UI Components
    
    private let emotionImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = RDDSKitAsset.Images.feelingSad.image
        return iv
    }()
    
    private lazy var emotionLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        lb.textColor = .white
        lb.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 10.adjusted)
        return lb
    }()
    
    // MARK: - View Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DreamWriteEmotionCVC {
    func setLayout() {
        self.addSubviews(emotionImageView, emotionLabel)
        
        emotionImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        emotionLabel.snp.makeConstraints { make in
            make.top.equalTo(emotionImageView.snp.bottom).offset(7)
            make.centerX.equalToSuperview()
        }
    }
    
    func setData(image: UIImage, text: String) {
        emotionImageView.image = image
        emotionLabel.text = text
        emotionLabel.sizeToFit()
    }
}

