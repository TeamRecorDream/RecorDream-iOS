//
//  DreamDetailViewModel.swift
//  
//
//  Created by 김수연 on 2022/12/04.
//

import Foundation

import Domain
import RD_Core

import RxSwift
import RxRelay

public class DreamDetailViewModel: ViewModelType {

    private let useCase: DreamDetailUseCase
    private let disposeBag = DisposeBag()
    let dreamId: String
    var audioURL: URL?
    var detailDreamData: DreamDetailEntity = DreamDetailEntity(recordId: "", date: "", title: "", content: "", emotion: 0, genre: [], note: "", voiceUrl: nil)

    // MARK: - Inputs
    
    public struct Input {
        let viewDidLoad: Observable<Void>
        let isModifyDismissed: Observable<Bool>
    }
  
    // MARK: - Outputs
    
    public struct Output {
        var fetchedDetailData = BehaviorRelay<DreamDetailEntity?>(value: nil)
        var loadingStatus = BehaviorRelay<Bool>(value: true)
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

        input.viewDidLoad
            .withUnretained(self)
            .subscribe(onNext: { (owner, _) in
                output.loadingStatus.accept(true)
                owner.useCase.fetchDetailRecord(recordId: self.dreamId)
        }).disposed(by: disposeBag)

        input.isModifyDismissed.subscribe(onNext: { isDismissed in
            if isDismissed {
                output.loadingStatus.accept(true)
                self.useCase.fetchDetailRecord(recordId: self.dreamId)
            }
        }).disposed(by: disposeBag)
    
        return output
    }
  
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
        let detailDreamData = self.useCase.fetchedDetailData

        detailDreamData.compactMap { $0 }
            .withUnretained(self)
            .subscribe(onNext: { owner, entity in
                output.loadingStatus.accept(false)
                output.fetchedDetailData.accept(entity)
                owner.audioURL = entity.voiceUrl
                owner.detailDreamData = entity
            }).disposed(by: disposeBag)
    }
}
