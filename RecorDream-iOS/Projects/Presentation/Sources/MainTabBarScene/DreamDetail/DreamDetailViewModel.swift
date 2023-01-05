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
    private let dreamId: String
  
    // MARK: - Inputs
    
    public struct Input {
        let viewWillAppear: Observable<Void>
    }
  
    // MARK: - Outputs
    
    public struct Output {
        var fetchedDetailData = BehaviorRelay<DreamDetailEntity?>(value: nil)
    }
    
    // MARK: - Coordination
  
    public init(useCase: DreamDetailUseCase, dreamId: String) {
        self.useCase = useCase
        self.dreamId = dreamId
    }
}

extension DreamDetailViewModel {
    public func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)

        input.viewWillAppear.subscribe(onNext: { _ in
            self.useCase.fetchDetailRecord(recordId: self.dreamId)
        }).disposed(by: disposeBag)
    
        return output
    }
  
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
        let detailDreamData = self.useCase.fetchedDetailData

        detailDreamData.compactMap { $0 }
            .subscribe(onNext: { entity in
                output.fetchedDetailData.accept(entity)
            }).disposed(by: disposeBag)
    }
}
