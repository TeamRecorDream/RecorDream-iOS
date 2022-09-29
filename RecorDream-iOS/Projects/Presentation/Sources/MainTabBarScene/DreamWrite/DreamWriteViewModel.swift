//
//  DreamWriteViewModel.swift
//  RD-Navigator
//
//  Created by Junho Lee on 2022/09/29.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import RxSwift

final class DreamWriteViewModel: ViewModelType {

    private let useCase: DreamWriteUseCase
    private let disposeBag = DisposeBag()
  
    // MARK: - Inputs
    
    struct Input {
    
    }
  
    // MARK: - Outputs
    
    struct Output {
    
    }
  
    init(useCase: DreamWriteUseCase) {
        self.useCase = useCase
    }
}

extension DreamWriteViewModel {
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)
        // input,output 상관관계 작성
    
        return output
    }
  
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
    
    }
}
