//
//  HomeViewModel.swift
//  
//
//  Created by 김수연 on 2022/10/23.
//

import Domain
import RD_Core

import RxSwift
import RxRelay

public class HomeViewModel: ViewModelType {

    private let useCase: HomeUseCase
    private let disposeBag = DisposeBag()
    
    internal var numberOfItems: Int = 0
    internal var fetchedDreamRecord = HomeEntity(nickname: "", records: [])
  
    // MARK: - Inputs
    
    public struct Input {
        let viewWillAppear: Observable<Bool>
    }
    
    // MARK: - Outputs
    
    public struct Output {
        var fetchedHomeData = BehaviorRelay<HomeEntity?>(value: nil)
        var loadingStatus = BehaviorRelay<Bool>(value: true)
    }
    
    // MARK: - Coordination
  
    public init(useCase: HomeUseCase) {
        self.useCase = useCase
    }
}

extension HomeViewModel: DreamCardCollectionViewAdapterDataSource {

    public func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)

        input.viewWillAppear.subscribe(onNext: { _ in
            output.loadingStatus.accept(true)
            self.useCase.fetchDreamRecord()
        }).disposed(by: disposeBag)

        return output
    }
  
    private func bindOutput(output: Output, disposeBag: DisposeBag) {

        let homeData = self.useCase.fetchedHomeData
        homeData
            .compactMap { $0 }
            .subscribe(onNext: { entity in
                output.loadingStatus.accept(false)
                output.fetchedHomeData.accept(entity)

                let count = entity.records.count
                self.numberOfItems = count
                self.fetchedDreamRecord = entity
            }).disposed(by: disposeBag)
    }
}
