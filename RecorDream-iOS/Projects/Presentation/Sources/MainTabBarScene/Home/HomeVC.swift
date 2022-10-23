//
//  HomeVC.swift
//  
//
//  Created by 김수연 on 2022/10/23.
//

import UIKit

import RD_DSKit

import RxSwift
import SnapKit

public class HomeVC: UIViewController {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    public var viewModel: HomeViewModel!
  
    // MARK: - UI Components
  
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModels()
    }
}

// MARK: - Methods

extension HomeVC {
  
    private func bindViewModels() {
        let input = HomeViewModel.Input()
        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
    }

}
