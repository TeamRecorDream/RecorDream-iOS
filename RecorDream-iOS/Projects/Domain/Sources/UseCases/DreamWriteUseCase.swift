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
    func writeDreamRecord(request: DreamWriteRequestEntity)
    var writeData: PublishSubject<DreamWriteEntity> { get set }
    var writeFail: PublishSubject<Error> { get set }
    func titleTextValidate(text: String)
    var isWriteEnabled: PublishSubject<Bool> { get set }
}

public class DefaultDreamWriteUseCase {
    
    private let repository: DreamWriteRepository
    private let disposeBag = DisposeBag()
    
    public var writeData = PublishSubject<DreamWriteEntity>()
    public var writeFail = PublishSubject<Error>()
    public var isWriteEnabled = PublishSubject<Bool>()
    
    public init(repository: DreamWriteRepository) {
        self.repository = repository
    }
}

extension DefaultDreamWriteUseCase: DreamWriteUseCase {
    public func writeDreamRecord(request: DreamWriteRequestEntity) {
    public func titleTextValidate(text: String) {
        self.isWriteEnabled.onNext(text.count > 0)
    }
        self.repository.writeDreamRecord(request: request)
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] entity in
            guard let self = self else { return }
            self.writeData.onNext(entity)
        }, onError: { err in
            self.writeFail.onNext(err)
        })
        .disposed(by: self.disposeBag)
    }
}
