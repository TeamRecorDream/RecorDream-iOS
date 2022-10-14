//
//  DreamWriteViewModel.swift
//  RD-Navigator
//
//  Created by Junho Lee on 2022/09/29.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Domain
import RD_Core

import RxSwift
import RxRelay

public protocol DreamWriteControllable {
    var viewDidDisappearEvent: PublishRelay<Void> { get }
    var closeButtonTapped: PublishRelay<Void> { get }
}

public class DreamWriteViewModel: ViewModelType, DreamWriteControllable {
    
    private let useCase: DreamWriteUseCase
    private let disposeBag = DisposeBag()
    
    // MARK: - Inputs
    
    public struct Input {
        let viewDidDisappearEvent: Observable<Bool>
        let closeButtonTapped: Observable<Void>
        var saveButtonTapped: Observable<Void>
    }
    
    // MARK: - Coordinator Protocol
    
    public let viewDidDisappearEvent = PublishRelay<Void>()
    public let closeButtonTapped = PublishRelay<Void>()
    
    // MARK: - Outputs
    
    public struct Output {
        var writeRequestSuccess = PublishRelay<Int>()
        var showNetworkError = PublishRelay<Void>()
    }
    
    // MARK: - Properties
    
    // mockData입니다
    let writeRequestEntity = BehaviorRelay<DreamWriteRequestEntity>(value: .init(title: "", date: "", content: "", emotion: 1, genre: [1], note: nil, voice: nil))
    
    public init(useCase: DreamWriteUseCase) {
        self.useCase = useCase
    }
}

extension DreamWriteViewModel {
    public func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        input.viewDidDisappearEvent.subscribe(onNext: { _ in
            self.viewDidDisappearEvent.accept(())
        }).disposed(by: disposeBag)
        
        input.closeButtonTapped.subscribe(onNext: {
            self.closeButtonTapped.accept(())
        }).disposed(by: disposeBag)
        
        input.saveButtonTapped.subscribe(onNext: { _ in
            self.useCase.writeDreamRecord(request: self.writeRequestEntity.value)
        })
        .disposed(by: self.disposeBag)
        
        self.bindOutput(output: output, disposeBag: disposeBag)
        
        return output
    }
    
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
        let writeRelay = useCase.writeData
        let writeError = useCase.writeFail
        
        writeRelay.subscribe(onNext: { entity in
            output.writeRequestSuccess.accept(entity.userId)
        })
        .disposed(by: self.disposeBag)
        
        writeError.subscribe(onNext: { _ in
            output.showNetworkError.accept(())
        })
        .disposed(by: self.disposeBag)
    }
}
