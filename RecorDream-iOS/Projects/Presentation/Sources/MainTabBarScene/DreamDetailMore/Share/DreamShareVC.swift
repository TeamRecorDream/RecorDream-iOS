//
//  DreamShareVC.swift
//  Presentation
//
//  Created by 김수연 on 2023/01/08.
//  Copyright © 2023 RecorDream-iOS. All rights reserved.
//

import UIKit

import RD_DSKit

import RxSwift
import SnapKit

public class DreamShareVC: UIViewController {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    public var viewModel: DreamShareViewModel!
    public var factory: ViewControllerFactory!
  
    // MARK: - UI Components


  
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModels()
    }

    // MARK: - UI & Layout

    private func setUI() {
        self.view.backgroundColor = RDDSKitAsset.Colors.dark.color
    }

    private func setLayout() {

    }
}

// MARK: - Methods

extension DreamShareVC {
  
    private func bindViewModels() {
        let input = DreamShareViewModel.Input()
        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
    }

}
