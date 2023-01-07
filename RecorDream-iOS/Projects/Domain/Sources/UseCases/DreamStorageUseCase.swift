//
//  DreamStorageUseCase.swift
//  Domain
//
//  Created by 정은희 on 2022/12/27.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

import Foundation

import RD_Core

import RxSwift

public protocol DreamStorageUseCase {
    func execute(requestValue: StorageFetchQuery)
    
    var fetchSuccess: PublishSubject<DreamStorageEntity.RecordList?> { get set }
}

public final class DefaultDreamStorageUseCase {
    private let repository: DreamStorageRepository
    private let disposeBag = DisposeBag()
    
    public var fetchSuccess = PublishSubject<DreamStorageEntity.RecordList?>()
    
    public init(repository: DreamStorageRepository) {
        self.repository = repository
    }
}

extension DefaultDreamStorageUseCase: DreamStorageUseCase {
    public func execute(requestValue: StorageFetchQuery) {
        self.repository.fetchDreamStorage(query: requestValue)
            .withUnretained(self)
            .subscribe(onNext: { owner, entity in
                guard let entity = entity else {
                    owner.fetchSuccess.onNext(nil)
                    return
                }
                self.fetchSuccess.onNext(entity)
            }).disposed(by: disposeBag)
    }
}
