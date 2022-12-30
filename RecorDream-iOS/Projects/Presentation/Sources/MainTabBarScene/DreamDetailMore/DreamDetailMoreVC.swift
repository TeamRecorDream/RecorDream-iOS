//
//  DreamDetailMoreVC.swift
//  PresentationTests
//
//  Created by 김수연 on 2022/12/30.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

import UIKit

import RD_DSKit

import RxSwift
import SnapKit

public class DreamDetailMoreVC: UIViewController {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    public var viewModel: DreamDetailMoreViewModel!
    public var factory: ViewControllerFactory!
  
    // MARK: - UI Components
  
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModels()
        self.setUI()
        self.setLayout()
    }

    // MARK: - UI & Layout
    private func setUI() {
        self.view.backgroundColor = RDDSKitAsset.Colors.dark.color.withAlphaComponent(0.65)
    }

    private func setLayout() {
        ///self.view.addSubviews()
    }
}

// MARK: - Methods

extension DreamDetailMoreVC {
  
    private func bindViewModels() {
        let input = DreamDetailMoreViewModel.Input()
        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
    }

}
