//
//  DreamWriteViewModel.swift
//  RD-Navigator
//
//  Created by Junho Lee on 2022/09/29.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

import Domain
import RD_Core

import RxSwift
import RxRelay

public class DreamWriteViewModel: ViewModelType {
    
    // MARK: - Inputs
    
    public struct Input {
        let viewDidLoad: Observable<Void>
        let closeButtonTapped: Observable<Void>
        let datePicked: Observable<Void>
        let voiceRecorded: Observable<URL>
        let titleTextChanged: Observable<String>
        let contentTextChanged: Observable<String>
        let emotionChagned: Observable<Int>
        let genreListChagned: Observable<[Int]>
        let noteTextChanged: Observable<String>
        let saveButtonTapped: Observable<Void>
    }
    
    // MARK: - Coordinator
    
    public let closeButtonTapped = PublishRelay<Void>()
    public let writeRequestSuccess = PublishRelay<Void>()
    
    // MARK: - Outputs
    
    public struct Output {
        var writeButtonEnabled = PublishRelay<Bool>()
        var showGenreCountCaution = PublishRelay<Bool>()
        var writeRequestSuccess = PublishRelay<Void>()
    }
    
    // MARK: - Properties
    
    private let useCase: DreamWriteUseCase
    private let disposeBag = DisposeBag()
    
    public enum DreamWriteViewModelType {
        case write
        case modify(postId: String)
    }
    
    private var viewModelType = DreamWriteViewModelType.write
    
    // mockData입니다
    let writeRequestEntity = BehaviorRelay<DreamWriteRequest>(value: .init(title: "", date: "", content: "", emotion: 1, genre: [1], note: nil, voice: nil))
    
    // MARK: - Initializer
    
    public init(useCase: DreamWriteUseCase, viewModelType: DreamWriteViewModelType) {
        self.useCase = useCase
        self.viewModelType = viewModelType
    }
}

extension DreamWriteViewModel {
    public func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        if case let .modify(postId) = self.viewModelType {
            input.viewDidLoad.subscribe(onNext: { _ in
                self.useCase.fetchDreamRecord(postId: postId)
            }).disposed(by: disposeBag)
        }
        
        input.closeButtonTapped.subscribe(onNext: {
            self.closeButtonTapped.accept(())
        }).disposed(by: disposeBag)
        
        input.saveButtonTapped.subscribe(onNext: { _ in
            self.useCase.writeDreamRecord(request: self.writeRequestEntity.value)
        }).disposed(by: disposeBag)
        
        self.bindOutput(output: output, disposeBag: disposeBag)
        
        return output
    }
    
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
        let writeRelay = useCase.writeSuccess
        
        writeRelay.subscribe(onNext: { entity in
            self.writeRequestSuccess.accept(())
            output.writeRequestSuccess.accept(())
        }).disposed(by: disposeBag)
    }
}
