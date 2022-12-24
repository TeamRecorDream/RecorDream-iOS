//
//  DreamStorageUseCase.swift
//  Domain
//
//  Created by 정은희 on 2022/12/24.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

import Foundation

import RD_Core

import RxSwift

public protocol DreamStorageUseCase {
    func fetch(filterType: StorageRequest)
    
    var fetchSuccess: PublishSubject<StorageEntity> { get set }
    var fetchFail: PublishSubject<Error> { get set }
}

public final class DefaultDreamStorageUseCase {
    private let repository: DreamStorageRepository
    private let disposeBag = DisposeBag()
    
    public var fetchSuccess = PublishSubject<StorageEntity>()
    public var fetchFail = PublishSubject<Error>()
    
    public init(repository: DreamStorageRepository) {
        self.repository = repository
    }
}

extension DefaultDreamStorageUseCase: DreamStorageUseCase {
    public func fetch(filterType: StorageRequest) {
        self.repository.requestStorageFetch(filter: filterType)
            .subscribe(onNext: { [weak self] entity in
                guard let self = self else { return }
                guard let entity = entity else {
                    return }
                self.fetchSuccess.onNext(entity)
            }, onError: { err in
                self.fetchFail.onNext(err)
            }).disposed(by: disposeBag)
    }
}
