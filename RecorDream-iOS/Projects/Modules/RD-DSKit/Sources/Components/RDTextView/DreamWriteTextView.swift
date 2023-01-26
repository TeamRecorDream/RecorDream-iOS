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
        willSet { self.text = newValue }
    }
    
    public var initText: String? {
        willSet {
            self.text = newValue
            self.textColor = .white
            guard newValue == self.placeHolderText else { return }
            self.textColor = .white.withAlphaComponent(0.4)
        }
    }
    
    public var maxLength: Int?
    
    public var enterEnabled = true
    
    public lazy var sharedText: Observable<String>  = {
        return self.rx.text
            .orEmpty
            .asObservable()
    }()
    
    public lazy var didBeginEditing: Observable<Void> = {
        return self.rx.didBeginEditing
            .asObservable()
    }()
    
    public lazy var didEndEditing: Observable<Void> = {
        return self.rx.didEndEditing
            .asObservable()
    }()
    
    // MARK: - Life Cycles
    
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.setUI()
        self.bind()
        self.setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods
extension DreamWriteTextView {
    
    private func setUI() {
        self.showsVerticalScrollIndicator = true
        self.backgroundColor = .white.withAlphaComponent(0.05)
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        self.textContainerInset = UIEdgeInsets(top: 18.0, left: 16.0, bottom: 16.0, right: 16.0)
        self.font = RDDSKitFontFamily.Pretendard.medium.font(size: 14)
        self.textColor = .white.withAlphaComponent(0.4)
    }
    
    private func bind() {
        self.didBeginEditing
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                if self.text == self.placeHolderText {
                    self.text = nil
                    self.textColor = .white
                }
            }).disposed(by: disposeBag)
        
        self.didEndEditing
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                if self.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    self.text = self.placeHolderText
                    self.textColor = .white.withAlphaComponent(0.4)
                }
            }).disposed(by: disposeBag)
        
        self.sharedText
            .withUnretained(self)
            .subscribe { owner, string in
                // 마지막이 개행일 경우 삭제
                if !owner.enterEnabled, let last = string.last {
                    let lastString = String(last)
                    if lastString == "\n" {
                        owner.deleteBackward()
                        return
                    }
                }
                
                // 플레이스홀더와 다른 경우만 처리
                guard string != owner.placeHolderText else {
                    return
                }
                owner.setAttributedText()
                
                // 최대 길이 존재할 경우 삭제
                guard let max = owner.maxLength else {
                    return
                }
                if owner.text!.count > max {
                    owner.deleteBackward()
                }
            }.disposed(by: self.disposeBag)
    }
    
    private func setDelegate() {
        self.subviews.forEach { view in
            guard let scrollView = view as? UIScrollView else { return }
            scrollView.delegate = self
        }
    }
    
    private func setAttributedText() {
        if let text = self.text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 5.6
            attributeString.addAttribute(
                NSAttributedString.Key.paragraphStyle,
                value: style,
                range: NSMakeRange(0, attributeString.length)
            )
            attributeString.addAttribute(
                NSAttributedString.Key.foregroundColor,
                value: UIColor.white,
                range: NSMakeRange(0, attributeString.length)
            )
            attributeString.addAttribute(
                NSAttributedString.Key.font,
                value: RD_DSKit.RDDSKitFontFamily.Pretendard.medium.font(size: 14),
                range: NSMakeRange(0, attributeString.length)
            )
            self.attributedText = attributeString
        }
    }
}

// MARK: - Public Methods

extension DreamWriteTextView {
    @discardableResult
    public func setMaxLength(_ maxLength: Int) -> Self {
        self.maxLength = maxLength
        
        return self
    }
    
    @discardableResult
    public func placeHolder(_ text: String) -> Self {
        self.placeHolderText = text
        
        return self
    }
    
    @discardableResult
    public func enableEnter(_ isEnabled: Bool = true) -> Self {
        self.enterEnabled = isEnabled
        
        return self
    }
}

extension DreamWriteTextView: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        (scrollView.subviews[(scrollView.subviews.count - 1)].subviews[0]).backgroundColor = UIColor.white
    }
}
