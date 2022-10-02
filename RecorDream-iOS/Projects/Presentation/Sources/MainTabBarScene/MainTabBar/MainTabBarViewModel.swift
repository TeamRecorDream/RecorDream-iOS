//
//  MainTabBarViewModel.swift
//  Presentation
//
//  Created by Junho Lee on 2022/09/30.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation
import RD_Core

import RxSwift
import RxRelay

public protocol MainTabBarControllable {
    var middleButtonTapped: PublishRelay<Void> { get }
}

public class MainTabBarViewModel: ViewModelType, MainTabBarControllable {
    
    private let disposeBag = DisposeBag()
      
    // MARK: - Inputs
    
    public struct Input {
        let middleButtonTapped: Observable<Void>
    }
  
    // MARK: - Coordinator Protocol
    
    public let middleButtonTapped = PublishRelay<Void>()
    
    // MARK: - Outputs
    
    public struct Output {
    
    }
  
    public init() { }
}

extension MainTabBarViewModel {
    public func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        input.middleButtonTapped.subscribe(onNext: {
            self.middleButtonTapped.accept(())
        }).disposed(by: disposeBag)
        
        self.bindOutput(output: output, disposeBag: disposeBag)
        return output
    }
  
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
    
    }
}

