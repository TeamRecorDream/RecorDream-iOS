//
//  DefaultStorageRepository.swift
//  Data
//
//  Created by 정은희 on 2022/12/27.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

import Domain
import RD_Network

import RxSwift

public final class DefaultStorageRepository {
    
    private let recordService: RecordService
    private let disposeBag = DisposeBag()
    
    public init(recordService: RecordService) {
        self.recordService = recordService
    }
}

extension DefaultStorageRepository: DreamStorageRepository {
    public func fetchDreamStorage(query: Domain.StorageFetchQuery) -> RxSwift.Observable<Domain.DreamStorageEntity.RecordList> {
        return Observable.create { observer in
            self.recordService.fetchStorage(filter: query.filterType)
                .subscribe(onNext: { response in
                    guard let entity = response?.toDomain() else { return }
                    observer.onNext(entity)
                }, onError: { err in
                    observer.onError(err)
                }).disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}
