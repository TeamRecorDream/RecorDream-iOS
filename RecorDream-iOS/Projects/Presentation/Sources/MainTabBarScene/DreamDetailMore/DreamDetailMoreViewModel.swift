//
//  DreamDetailMoreViewModel.swift
//  PresentationTests
//
//  Created by 김수연 on 2022/12/30.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

import Domain
import RD_Core

import RxSwift
import RxRelay

public class DreamDetailMoreViewModel: ViewModelType {

    private let useCase: DreamDetailMoreUseCase
    private let disposeBag = DisposeBag()
  
    // MARK: - Inputs
    
    public struct Input {
    
    }
    
    // MARK: - CoordinatorInput
  
    // MARK: - Outputs
    
    public struct Output {
    
    }
    
    // MARK: - Coordination
  
    public init(useCase: DreamDetailMoreUseCase) {
        self.useCase = useCase
    }
}

extension DreamDetailMoreViewModel {
    public func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)
        // input,output 상관관계 작성
    
        return output
    }
  
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
    
    }
}
