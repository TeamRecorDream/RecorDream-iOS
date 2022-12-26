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
    let fetchRequestEntity = BehaviorRelay<DreamSearchQuery>(value: .init(keyword: "")) // internel property
    private let useCase: DreamSearchUseCase
    private let disposeBag = DisposeBag()

    // MARK: - Reactive Stuff
    public struct Input {
        let currentSearchQuery: Observable<String> // 입력값
        let returnButtonTapped: Observable<Void> // 트리거
    }
    public struct Output {
        var searchResultModelFetched = PublishRelay<DreamSearchEntity>() // 결과값
        var loadingStatus = PublishRelay<Bool>() // 로딩창용
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
        
        // 여기서 잘못된 것 같은데 더 해줘야 할 것이 있는지...!
        // 두번째 짐작으로는 뷰컨의 setDataSource() 부분에서 빠진게 있는 것 같은데 일단 보기 쉽게 주석 달아놓았습니다...!
        
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
