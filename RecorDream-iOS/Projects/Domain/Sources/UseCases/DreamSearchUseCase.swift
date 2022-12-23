//
//  DreamSearchUseCase.swift
//  DomainTests
//
//  Created by 정은희 on 2022/11/09.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

import RD_Core

import RxSwift

public protocol DreamSearchUseCase {
    func execute(requestValue: DreamSearchQuery)
    
    var fetchSuccess: PublishSubject<DreamSearchEntity> { get set }
    var fetchFail: PublishSubject<Error> { get set }
}

public final class DefaultDreamSearchUseCase {
    private let repository: DreamSearchRepository
    private let disposeBag = DisposeBag()
    
    public var fetchSuccess = PublishSubject<DreamSearchEntity>()
    public var fetchFail = PublishSubject<Error>()

    public init(dreamSearchRepository: DreamSearchRepository) {
        self.repository = dreamSearchRepository
    }
}

extension DefaultDreamSearchUseCase: DreamSearchUseCase {
    public func execute(requestValue: DreamSearchQuery) {
        self.repository.fetchDreamSearchList(query: requestValue)
            .subscribe(onNext: { [weak self] entity in
                guard let self = self else { return }
                self.fetchSuccess.onNext(entity)
            }, onError: { err in
                self.fetchFail.onNext(err)
            }).disposed(by: disposeBag)
    }
}
