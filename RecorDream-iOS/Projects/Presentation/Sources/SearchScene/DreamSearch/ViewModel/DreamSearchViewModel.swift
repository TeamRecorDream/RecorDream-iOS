//
//  DreamSearchViewModel.swift
//  Presentation
//
//  Created by 정은희 on 2022/11/08.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

import Domain
import RD_Core

import RxSwift
import RxRelay

public final class DreamSearchViewModel {
    // MARK: - Properties
    let fetchRequestEntity = BehaviorRelay<DreamSearchQuery>(value: .init(keyword: ""))
    private let useCase: DreamSearchUseCase
    private let disposeBag = DisposeBag()

    // MARK: - Reactive Stuff
    public struct Input {
        let currentSearchQuery: Observable<String>
        let returnButtonTapped: Observable<Void>
    }
    public struct Output {
        var searchResultModelFetched = PublishRelay<DreamSearchEntity>()
        var loadingStatus = PublishRelay<Bool>()
    }
    
    // MARK: - Initialization
    public init(useCase: DreamSearchUseCase) {
        self.useCase = useCase
    }
}

// MARK: - Extensions
extension DreamSearchViewModel: ViewModelType {
    public func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)
      
        input.currentSearchQuery.subscribe(onNext: { query in
            self.fetchRequestEntity.accept(DreamSearchQuery.init(keyword: query))
        }).disposed(by: disposeBag)
        
        input.returnButtonTapped.subscribe(onNext: { _ in
            self.useCase.execute(requestValue: self.fetchRequestEntity.value)
            output.loadingStatus.accept(true)
        }).disposed(by: disposeBag)
        
        return output
    }
}
extension DreamSearchViewModel {
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
        let searchRelay = self.useCase.fetchSuccess
        let searchError = self.useCase.fetchFail
        
        searchRelay.subscribe(onNext: { entity in
            output.searchResultModelFetched.accept(entity)
            output.loadingStatus.accept(false)
        }).disposed(by: disposeBag)
        
        searchError.subscribe(onNext: { _ in
            output.loadingStatus.accept(true)
        }).disposed(by: disposeBag)
    }
}
