//
//  SplashViewModel.swift
//  PresentationTests
//
//  Created by Junho Lee on 2023/02/05.
//  Copyright © 2023 RecorDream-iOS. All rights reserved.
//

import Foundation

import Domain
import RD_Core

import RxSwift
import RxCocoa

public final class SplashViewModel {
    private let useCase: AuthUseCase
    private let disposeBag = DisposeBag()
    
    // MARK: - Inputs
    public struct Input {
        let checkVersion: Observable<Void>
    }
    
    // MARK: - Outputs
    public struct Output {
        var versionChecked = PublishRelay<VersionCheckResult>()
    }
    
    // MARK: - Initialization
    public init(useCase: AuthUseCase) {
        self.useCase = useCase
    }
}

// MARK: - Transform
extension SplashViewModel: ViewModelType {
    public func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)
        
        input.checkVersion
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.useCase.checkVersion()
            }).disposed(by: disposeBag)
        
        return output
    }
    
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
        let checkVersionResult = self.useCase.versionChecked
        
        checkVersionResult
            .bind(to: output.versionChecked)
            .disposed(by: self.disposeBag)
    }
}

