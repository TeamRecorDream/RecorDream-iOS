//
//  HomeUseCase.swift
//  
//
//  Created by 김수연 on 2022/10/23.
//

import RxSwift
import RxRelay

public protocol HomeUseCase {
    func fetchDreamRecord()
    func vaildateRecordExistence()

    var fetchedHomeData: PublishSubject<HomeEntity?> { get set }
    var isExistRecord: PublishSubject<Bool> { get set }
}

public class DefaultHomeUseCase {
  
    private let repository: HomeRepository
    private let disposeBag = DisposeBag()
    
    public var fetchedHomeData = PublishSubject<HomeEntity?>()
    public var isExistRecord = PublishSubject<Bool>()
  
    public init(repository: HomeRepository) {
        self.repository = repository
    }
}

extension DefaultHomeUseCase: HomeUseCase {

    public func fetchDreamRecord() {
        self.repository.fetchDreamRecord()
            .subscribe(onNext: { entity in
                self.fetchedHomeData.onNext(entity)
            }).disposed(by: self.disposeBag)
    }

    public func vaildateRecordExistence() {
        self.repository.fetchDreamRecord()
            .subscribe(onNext: { entity in
                guard let records = entity.records else { return }
                if records.isEmpty {
                    self.isExistRecord.onNext(false)
                } else {
                    self.isExistRecord.onNext(true)
                }
            }).disposed(by: self.disposeBag)
    }
}
