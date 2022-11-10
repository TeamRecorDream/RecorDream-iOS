//
//  HomeViewModel.swift
//  
//
//  Created by 김수연 on 2022/10/23.
//

import Domain
import RD_Core

import RxSwift
import RxRelay

public class HomeViewModel: ViewModelType {

    //private let useCase: HomeUseCase
    private let disposeBag = DisposeBag()
  
    // MARK: - Inputs
    
    public struct Input {
    
    }
    
    // MARK: - CoordinatorInput
  
    // MARK: - Outputs
    
    public struct Output {
    
    }
    
    // MARK: - Coordination
  
    public init() {
        //self.useCase = useCase
    }
}

extension HomeViewModel {
    public func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)
        // input,output 상관관계 작성

        return output
    }
  
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
    }
}

extension HomeViewModel: DreamCardCollectionViewAdapterDataSource {
    var numberOfItems: Int {
        return 10
    }
}
