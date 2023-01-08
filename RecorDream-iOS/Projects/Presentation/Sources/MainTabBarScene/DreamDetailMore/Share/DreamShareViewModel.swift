//
//  DreamShareViewModel.swift
//  Presentation
//
//  Created by 김수연 on 2023/01/08.
//  Copyright © 2023 RecorDream-iOS. All rights reserved.
//

import Domain
import RD_Core

import RxSwift
import RxRelay

public class DreamShareViewModel: ViewModelType {

    private let useCase: DreamShareUseCase
    private let disposeBag = DisposeBag()
  
    // MARK: - Inputs
    
    public struct Input {
    
    }
    
    // MARK: - CoordinatorInput
  
    // MARK: - Outputs
    
    public struct Output {
    
    }
    
    // MARK: - Coordination
  
    public init(useCase: DreamShareUseCase) {
        self.useCase = useCase
    }
}

extension DreamShareViewModel {
    public func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)
        // input,output 상관관계 작성
    
        return output
    }
  
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
    
    }
}
