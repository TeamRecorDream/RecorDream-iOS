//
//  AuthUseCase.swift
//  Domain
//
//  Created by 정은희 on 2022/12/05.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

import RD_Core

import RxSwift

public protocol AuthUseCase {
    func login(request: AuthRequest)
    
    var authSuccess: PublishSubject<AuthEntity> { get set }
    var authFail: PublishSubject<Error> { get set }
}

public final class DefaultAuthUseCase {
    private let repository: AuthRepository
    private let disposeBag = DisposeBag()
    
    public var authSuccess = PublishSubject<AuthEntity>()
    public var authFail = PublishSubject<Error>()
    
    public init(repository: AuthRepository) {
        self.repository = repository
    }
}

extension DefaultAuthUseCase: AuthUseCase {
    public func login(request: AuthRequest) {
        self.repository.requestAuth(request: request)
            .filter { $0 != nil }
            .subscribe(onNext: { [weak self] entity in
                guard let self = self else { return }
                guard let entity = entity else {
                    return }
                DefaultUserDefaultManager.set(value: entity.accessToken, keyPath: C.accessToken)
                DefaultUserDefaultManager.set(value: entity.refreshToken, keyPath: C.refreshToken)
                self.authSuccess.onNext(entity)
            }, onError: { err in
                self.authFail.onNext(err)
            }).disposed(by: disposeBag)
    }
}
