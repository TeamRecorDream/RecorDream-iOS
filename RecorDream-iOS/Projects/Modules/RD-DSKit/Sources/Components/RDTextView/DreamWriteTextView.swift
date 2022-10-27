//
//  DreamWriteTextView.swift
//  RD-DSKit
//
//  Created by Junho Lee on 2022/10/06.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_Core

import RxSwift
import RxCocoa
import SnapKit

public class DreamWriteTextView: UITextView {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    private var placeHolderText = "꿈의 제목을 남겨주세요" {
        didSet { self.text = placeHolderText }
    }
    
    public var initText: String? {
        willSet {
            self.text = newValue
            self.textColor = .white
        }
    }
    
    public var endEditing: ControlEvent<Void> {
        return self.rx.didEndEditing
    }
    
    // MARK: - Life Cycles
    
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
      super.init(frame: frame, textContainer: textContainer)
        self.setUI()
        self.bind()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setUI()
        self.bind()
    }
}

    // MARK: - Methods
extension DreamWriteTextView {
    
    private func setUI() {
        self.backgroundColor = .white.withAlphaComponent(0.05)
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        self.textContainerInset = UIEdgeInsets(top: 18.0, left: 16.0, bottom: 16.0, right: 16.0)
        self.font = RDDSKitFontFamily.Pretendard.medium.font(size: 14)
        self.text = placeHolderText
        self.textColor = .white.withAlphaComponent(0.4)
    }
    
    private func bind() {
        self.rx.didBeginEditing
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                if self.text == self.placeHolderText {
                    self.text = nil
                    self.textColor = .white
                }
            }).disposed(by: disposeBag)
        
        self.rx.didEndEditing
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                if self.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    self.text = self.placeHolderText
                    self.textColor = .white.withAlphaComponent(0.4)
                }
                self.endEditing(true)
            }).disposed(by: disposeBag)
    }
    
    @discardableResult
    public func placeHolder(_ text: String) -> Self {
        self.placeHolderText = text
        
        return self
    }
}
