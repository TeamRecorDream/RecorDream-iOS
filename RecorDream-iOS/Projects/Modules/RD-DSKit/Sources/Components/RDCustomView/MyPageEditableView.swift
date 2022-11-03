//
//  MyPageEditableView.swift
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

public class MyPageEditableView: UIView {
    
    // MARK: - Properties
    
    public enum EndEditOutput {
        case noText
        case endWithProperText(text: String)
    }
    
    private let disposeBag = DisposeBag()
    
    public var endEditingWithText = PublishRelay<EndEditOutput>()
    
    // MARK: - UI Components
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 16.adjusted)
        label.textColor = .white
        label.sizeToFit()
        return label
    }()
    
    private let editingTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = .white
        tf.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 16.adjusted)
        tf.tintColor = .white
        tf.sizeToFit()
        tf.isHidden = true
        return tf
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

extension MyPageEditableView {
    private func setUI() {
        self.backgroundColor = RDDSKitAsset.Colors.dark.color
    }
    
    private func setLayout() {
        self.addSubviews(resultLabel, editingTextField)
        
        self.snp.makeConstraints { make in
            make.height.equalTo(resultLabel)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        editingTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}

// MARK: - Methods

extension MyPageEditableView {
    private func bind() {
        Observable.merge(editingTextField.rx.controlEvent(.editingDidEndOnExit).asObservable(), editingTextField.rx.controlEvent(.editingDidEnd).asObservable())
            .withUnretained(self)
            .subscribe(onNext: { (strongSelf, _) in
                if let text = strongSelf.editingTextField.text,
                   !text.isEmpty {
                    strongSelf.resultLabel.text = text
                    self.endEditingWithText.accept(.endWithProperText(text: text))
                } else {
                    strongSelf.endEditingWithText.accept(.noText)
                }
                strongSelf.rx.isEditing.onNext(false)
            }).disposed(by: disposeBag)
        
        editingTextField.rx.text
            .orEmpty
            .scan("") { (previous, new) -> String in
                return (new.count > 8) ? previous : new
            }
            .bind(to: editingTextField.rx.text)
            .disposed(by: disposeBag)
    }
    
    public func updateEditingStatus(_ isEditing: Bool) {
        resultLabel.isHidden = isEditing
        
        editingTextField.isHidden = !isEditing
        if isEditing {
            editingTextField.becomeFirstResponder()
        }
    }
}

extension Reactive where Base: MyPageEditableView {
    public var isEditing: Binder<Bool> {
        return Binder(base) { view, isEditing in
            view.updateEditingStatus(isEditing)
        }
    }
}

