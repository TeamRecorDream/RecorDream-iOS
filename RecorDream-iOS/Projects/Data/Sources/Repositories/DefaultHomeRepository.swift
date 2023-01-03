//
//  DefaultHomeRepository.swift
//  
//
//  Created by 김수연 on 2022/10/23.
//

import Foundation

import Domain
import RD_Network

import RxSwift

public class DefaultHomeRepository {

    private var recordService: RecordService
    private let disposeBag = DisposeBag()

    public init(recordService: RecordService) {
        self.recordService = recordService
    }
}

extension DefaultHomeRepository: HomeRepository {
    public func fetchDreamRecord() -> Observable<HomeEntity> {
        return Observable.create({ observer in
            self.recordService.fetchHomeRecord()
                .subscribe(onNext: { response in
                    guard let entity = response?.toDomain() else {
                        return
                    }
                    observer.onNext(entity)
                }, onError: { err in
                    observer.onError(err)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        })
    }
}
