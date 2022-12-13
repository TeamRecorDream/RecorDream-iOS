//
//  LoginViewModel.swift
//  Presentation
//
//  Created by 정은희 on 2022/12/05.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

import Domain
import RD_Core

import RxSwift
import RxCocoa

public final class LoginViewModel {
    private let useCase: AuthUseCase
    private let disposeBag = DisposeBag()
    
    // MARK: - Inputs
    public struct Input {
        let loginButtonTapped: Observable<AuthPlatformType>
        let loginRequestFail: Observable<AuthPlatformType>
        let loginRequestSuccess: Observable<AuthRequest>
    }
    
    // MARK: - Outputs
    public struct Output {
        var loginRequest = PublishRelay<AuthPlatformType>()
        var loginSuccess = PublishRelay<AuthEntity>()
        var showLoginFailError = PublishRelay<AuthPlatformType>()
        var showNetworkError = PublishRelay<Void>()
    }
    
    // MARK: - Properties
    let authRequestEntity = BehaviorRelay<AuthRequest>(value: .init(kakaoToken: "", appleToken: "", fcmToken: ""))
    
    // MARK: - Initialization
    init(useCase: AuthUseCase) {
        self.useCase = useCase
    }
}

// MARK: - Transform
extension LoginViewModel: ViewModelType {
    public func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)
        
        input.loginButtonTapped
            .subscribe(onNext: { platformType in
                output.loginRequest.accept(platformType)
            }).disposed(by: disposeBag)
        
        input.loginRequestSuccess
            .subscribe(onNext: { [weak self] request in
                guard let self = self else { return }
                self.useCase.login(request: self.authRequestEntity.value)
            }).disposed(by: disposeBag)
        
        input.loginRequestFail
            .subscribe(onNext: { platformType in
                output.showLoginFailError.accept(platformType)
            }).disposed(by: disposeBag)
        
        return output
    }
    
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
        let loginRelay = useCase.authSuccess
        let loginError = useCase.authFail
        
        loginRelay.subscribe(onNext: { entity in
            output.loginSuccess.accept(entity)
        }).disposed(by: disposeBag)
        
        loginError.subscribe(onNext: { _ in
            output.showNetworkError.accept(())
        }).disposed(by: disposeBag)
    }
}
