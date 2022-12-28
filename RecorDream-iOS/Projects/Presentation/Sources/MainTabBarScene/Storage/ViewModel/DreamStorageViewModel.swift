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
    let fetchRequestEntity = BehaviorRelay<StorageFetchQuery>(value: .init(filterType: 0))
    private let useCase: DreamStorageUseCase
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactive Stuff
    public struct Input {
        let viewDidLoad: Observable<Void>
        let filterButtonTapped: Observable<Int>
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
        
        input.viewDidLoad.subscribe(onNext: { _ in
            self.useCase.execute(requestValue: .init(filterType: 0))
            output.loadingStatus.accept(true)
        }).disposed(by: disposeBag)
        
        input.filterButtonTapped.subscribe(onNext: { selectedType in
            self.useCase.execute(requestValue: .init(filterType: selectedType))
            output.loadingStatus.accept(true)
        }).disposed(by: disposeBag)
        
        return output
    }
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
        let storageFetchedData = self.useCase.fetchSuccess
        let storageFetchError = self.useCase.fetchFail
        
        storageFetchedData
            .compactMap { $0 }
            .subscribe(onNext: { entity in
                output.storageDataFetched.accept(entity)
                output.loadingStatus.accept(false)
            }).disposed(by: disposeBag)
        
        storageFetchError.subscribe(onNext: { _ in
            output.loadingStatus.accept(true)
        }).disposed(by: disposeBag)
    }
}
