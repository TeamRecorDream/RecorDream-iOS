//
//  DreamStorageViewModel.swift
//  Presentation
//
//  Created by 정은희 on 2022/12/24.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

import Domain
import RD_Core
import RD_DSKit

import RxSwift
import RxCocoa

public final class DreamStorageViewModel {
    // MARK: - Properties
    var previousFetchQuery = StorageFetchQuery.init(filterType: 0)
    var fetchedDreamRecord = DreamStorageEntity.RecordList(recordsCount: 0, records: [])
    private let useCase: DreamStorageUseCase
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactive Stuff
    public struct Input {
        let viewDidLoad: Observable<Void>
        let filterButtonTapped: Observable<Int>
        let viewWillAppear: Observable<Bool>
        let dismissDetail: Observable<Void>
    }
    public struct Output {
        var storageDataFetched = BehaviorRelay<DreamStorageEntity.RecordList?>(value: nil)
        var loadingStatus = BehaviorRelay<Bool>(value: true)
    }
    
    // MARK: - Initialization
    public init(useCase: DreamStorageUseCase) {
        self.useCase = useCase
    }
}

extension DreamStorageViewModel: ViewModelType {
    public func transform(from input: Input, disposeBag: RxSwift.DisposeBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)
        
        input.viewDidLoad
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.useCase.execute(requestValue: .init(filterType: 0))
                output.loadingStatus.accept(true)
            }).disposed(by: disposeBag)
        
        input.filterButtonTapped
            .withUnretained(self)
            .subscribe(onNext: { owner, selectedType in
                owner.useCase.execute(requestValue: .init(filterType: selectedType))
                owner.previousFetchQuery = .init(filterType: selectedType)
            }).disposed(by: disposeBag)
        
        input.viewWillAppear
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.useCase.execute(requestValue: .init(filterType: 0))
                owner.previousFetchQuery = .init(filterType: 0)
                output.loadingStatus.accept(true)
            }).disposed(by: disposeBag)
        
        input.dismissDetail
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.useCase.execute(requestValue: owner.previousFetchQuery)
                output.loadingStatus.accept(true)
            }).disposed(by: disposeBag)
        
        return output
    }
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
        let storageFetchedData = self.useCase.fetchSuccess
        
        storageFetchedData
            .subscribe(onNext: { entity in
                // 에러 처리 용도
                let emptyResponse = entity == nil
                
                output.loadingStatus.accept(false)
                guard let model = entity else { return }
                output.storageDataFetched.accept(model)
                self.fetchedDreamRecord = model
            }).disposed(by: disposeBag)
    }
}
