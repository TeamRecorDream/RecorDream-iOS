//
//  DreamDetailUseCase.swift
//  
//
//  Created by 김수연 on 2022/12/04.
//

import RxSwift
import RxRelay

public protocol DreamDetailUseCase {
    func fetchDetailRecord(recordId: String)

    var fetchedDetailData: PublishSubject<DreamDetailEntity?> { get set }
}

public class DefaultDreamDetailUseCase {
  
    private let repository: DreamDetailRepository
    private let disposeBag = DisposeBag()

    public var fetchedDetailData = PublishSubject<DreamDetailEntity?>()

    public init(repository: DreamDetailRepository) {
        self.repository = repository
    }
}

extension DefaultDreamDetailUseCase: DreamDetailUseCase {

    public func fetchDetailRecord(recordId: String) {
        self.repository.fetchDetailRecord(recordId: recordId)
            .subscribe(onNext: { entity in
                self.fetchedDetailData.onNext(entity)
            }).disposed(by: self.disposeBag)
    }
}
