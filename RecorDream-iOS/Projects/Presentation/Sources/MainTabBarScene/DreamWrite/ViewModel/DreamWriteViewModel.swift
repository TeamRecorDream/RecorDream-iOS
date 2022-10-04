//
//  DreamWriteViewModel.swift
//  RD-Navigator
//
//  Created by Junho Lee on 2022/09/29.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Domain
import RD_Core

import RxSwift
import RxRelay

public protocol DreamWriteControllable {
    var viewDidDisappearEvent: PublishRelay<Void> { get }
}

public class DreamWriteViewModel: ViewModelType, DreamWriteControllable {
    
    private let useCase: DreamWriteUseCase
    private let disposeBag = DisposeBag()
      
    // MARK: - Inputs
    
    public struct Input {
        let viewDidDisappearEvent: Observable<Void>
    }
  
    // MARK: - Coordinator Protocol
    
    public let viewDidDisappearEvent = PublishRelay<Void>()
    
    // MARK: - Outputs
    
    public struct Output {
    
    }
  
    public init(useCase: DreamWriteUseCase) {
        self.useCase = useCase
    }
}

extension DreamWriteViewModel {
    public func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        input.viewDidDisappearEvent.subscribe(onNext: {
            self.viewDidDisappearEvent.accept(())
        }).disposed(by: disposeBag)
        
        self.bindOutput(output: output, disposeBag: disposeBag)
    
        return output
    }
  
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
    
    }
}
