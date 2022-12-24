//
//  DefaultSearchRepository.swift
//  Data
//
//  Created by 정은희 on 2022/12/24.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

import Domain
import RD_Network

import RxSwift

public final class DefaultSearchRepository {
    
    private let recordService: RecordService
    private let disposeBag = DisposeBag()
    
    public init(recordService: RecordService) {
        self.recordService = recordService
    }
}

extension DefaultSearchRepository: DreamSearchRepository {
    public func fetchDreamSearchList(query: DreamSearchQuery) -> RxSwift.Observable<DreamSearchEntity> {
        return Observable.create { observer in
            self.recordService.searchDreamRecord(query: query.keyword)
                .subscribe(onNext: { response in
                    guard let entity = response?.toDomain() else { return }
                    observer.onNext(.init(recordsCount: entity.recordsCount, records: entity.records))
                }, onError: { err in
                    observer.onError(err)
                }).disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}
