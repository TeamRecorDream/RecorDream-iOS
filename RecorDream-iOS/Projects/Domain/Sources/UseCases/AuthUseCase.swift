//
//  AuthUseCase.swift
//  Domain
//
//  Created by 정은희 on 2022/12/05.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

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
    
    init(repository: AuthRepository) {
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
                self.authSuccess.onNext(entity)
                // TODO: - 토큰 저장 처리
            }, onError: { err in
                self.authFail.onNext(err)
            }).disposed(by: disposeBag)
    }
}
