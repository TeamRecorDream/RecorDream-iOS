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
    let dreamDetailData: DreamDetailEntity
  
    // MARK: - Inputs
    
    public struct Input {
        let deleteButtonTapped: Observable<Void>
    }

    // MARK: - Outputs
    
    public struct Output {
        var popToHome = PublishRelay<Void>()
    }
    
    // MARK: - Coordination
  
    public init(useCase: DreamDetailMoreUseCase, dreamDetailData: DreamDetailEntity) {
        self.useCase = useCase
        self.dreamDetailData = dreamDetailData
    }
}

extension DreamDetailMoreViewModel {
    public func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)

        input.deleteButtonTapped.subscribe(onNext: { _ in
            self.useCase.deleteRecord(recordId: self.dreamDetailData.recordId)
        }).disposed(by: disposeBag)
    
        return output
    }
  
    private func bindOutput(output: Output, disposeBag: DisposeBag) {

        let deleteSuccessed = self.useCase.deleteRecordSuccess

        deleteSuccessed.bind { success in
            output.popToHome.accept(())
        }.disposed(by: disposeBag)
    }
}
