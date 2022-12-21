//
//  DreamDetailViewModel.swift
//  
//
//  Created by 김수연 on 2022/12/04.
//

import Domain
import RD_Core

import RxSwift
import RxRelay

public class DreamDetailViewModel: ViewModelType {

    private let useCase: DreamDetailUseCase
    private let disposeBag = DisposeBag()
  
    // MARK: - Inputs
    
    public struct Input {
    
    }
    
    // MARK: - CoordinatorInput
  
    // MARK: - Outputs
    
    public struct Output {
    
    }
    
    // MARK: - Coordination
  
    public init(useCase: DreamDetailUseCase) {
        self.useCase = useCase
    }
}

extension DreamDetailViewModel {
    public func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)
        // input,output 상관관계 작성
    
        return output
    }
  
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
    
    }
}
