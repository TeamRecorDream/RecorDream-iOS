//
//  DreamWriteUseCase.swift
//  RD-Navigator
//
//  Created by Junho Lee on 2022/09/29.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

import RxSwift

public protocol DreamWriteUseCase {
    func writeDreamRecord(request: DreamWriteRequest)
    func fetchDreamRecord(recordId: String)
    func titleTextValidate(text: String)
    func genreListCautionValidate(genreList: [Int])
    
    var writeSuccess: PublishSubject<Void> { get set }
    var isWriteEnabled: PublishSubject<Bool> { get set }
    var showCaution: PublishSubject<Bool> { get set }
    var fetchedRecord: PublishSubject<DreamWriteEntity> { get set }
}

public class DefaultDreamWriteUseCase {
    
    private let repository: DreamWriteRepository
    private let disposeBag = DisposeBag()
    
    public var writeSuccess = PublishSubject<Void>()
    public var isWriteEnabled = PublishSubject<Bool>()
    public var showCaution = PublishSubject<Bool>()
    public var fetchedRecord = PublishSubject<DreamWriteEntity>()
    
    public init(repository: DreamWriteRepository) {
        self.repository = repository
    }
}

extension DefaultDreamWriteUseCase: DreamWriteUseCase {
    public func titleTextValidate(text: String) {
        self.isWriteEnabled.onNext(text.count > 0)
    }
    
    public func genreListCautionValidate(genreList: [Int]) {
        self.showCaution.onNext(genreList.count >= 3)
    }
    
    public func fetchDreamRecord(recordId: String) {
        self.repository.fetchDreamRecord(recordId: recordId)
            .withUnretained(self)
            .subscribe(onNext: { strongSelf, entity in
                strongSelf.fetchedRecord.onNext(entity)
                strongSelf.genreListCautionValidate(genreList: entity.genreList)
            }).disposed(by: self.disposeBag)
    }
    
    public func writeDreamRecord(request: DreamWriteRequest) {
        self.repository.writeDreamRecord(request: request)
            .withUnretained(self)
            .subscribe(onNext: { strongSelf, entity in
            strongSelf.writeSuccess.onNext(())
        }).disposed(by: self.disposeBag)
    }
}
