//
//  RdTabBarItem.swift
//  RD-DSKitTests
//
//  Created by Junho Lee on 2022/09/24.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import SnapKit

final class RDTabBarItem: UIView {
    
    // MARK: - Properties
    
    private var imageView = UIImageView()
    private var titleLable = UILabel()
    
    var isSelected = false {
        didSet {
            reloadAppearnce()
        }
    }
    
    var selectedColor: UIColor = .black {
        didSet {
            reloadAppearnce()
        }
    }
    
    var deselectedColor: UIColor = .black {
        didSet {
            reloadAppearnce()
        }
    }
    
    var selectedImage = UIImage()
    
    var deselectedImage = UIImage()
    
    // MARK: - Initializer
    
    init(forItem item: UITabBarItem) {
        super.init(frame: CGRect(x: 0, y: 0, width: 28, height: 48))
    
        setUI()
        setItem(image: item.image, title: item.title, selectedImage: item.selectedImage)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setUI() {
        self.backgroundColor = .clear
        self.imageView.contentMode = .scaleAspectFill
        
        titleLable.font = UIFont.systemFont(ofSize: 12)
    }
    
    private func setItem(image: UIImage?, title: String?, selectedImage: UIImage?) {
        if let image = image, let title = title, let selectedImage = selectedImage {
            imageView.image = image.withRenderingMode(.alwaysTemplate)
            self.selectedImage = selectedImage
            self.deselectedImage = image
            titleLable.text = title
        }
    }
    
    private func reloadAppearnce() {
        self.tintColor = isSelected ? selectedColor : deselectedColor
        self.titleLable.textColor = isSelected ? selectedColor : deselectedColor
        self.imageView.image = isSelected ? selectedImage : deselectedImage
    }
    
    func itemIsSelected() {
        isSelected = isSelected ? true : false
    }
    
    // MARK: - Layout
    
    private func setLayout() {
        self.addSubview(imageView)
        self.addSubview(titleLable)
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(6)
            $0.leading.trailing.equalToSuperview()
            $0.width.height.equalTo(28)
        }
        
        titleLable.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(1)
            $0.bottom.equalToSuperview()
            $0.centerX.equalTo(imageView.snp.centerX)
        }
    }
}


