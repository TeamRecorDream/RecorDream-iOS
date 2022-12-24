//
//  DefaultStorageRepository.swift
//  Data
//
//  Created by 정은희 on 2022/12/24.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

import Domain
import RD_Core
import RD_Network

import RxSwift

public class DefaultStorageRepository {
    private let disposeBag = DisposeBag()
    private var recordService: RecordService
    
    public init(recordService: RecordService) {
        self.recordService = recordService
    }
}

extension DefaultStorageRepository: DreamStorageRepository {
    public func requestStorageFetch(filter: Domain.StorageRequest) -> RxSwift.Observable<Domain.StorageEntity?> {
        return Observable.create { observer in
            self.recordService.fetchStorage(filter: filter.selectedFilter)
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
