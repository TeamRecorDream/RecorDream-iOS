//
//  DreamWriteVC.swift
//  RD-Navigator
//
//  Created by Junho Lee on 2022/09/29.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RxSwift

public class DreamWriteVC: UIViewController {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    public var viewModel: DreamWriteViewModel!
  
    // MARK: - UI Components
  
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModels()
        self.setUI()
    }
}

// MARK: - Methods

extension DreamWriteVC {
    
    private func setUI() {
        self.view.backgroundColor = .brown
    }
  
    private func bindViewModels() {
        let input = DreamWriteViewModel.Input(viewDidDisappearEvent: self.rx.methodInvoked(#selector(UIViewController.viewDidDisappear(_:))).map { _ in })
        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
    }

}

// MARK: - Network

extension DreamWriteVC {

}
