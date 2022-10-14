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
    func writeDreamRecord(title: String, date: String, content: String, emotion: Int, genre: [Int], note: String?, voice: URL?)
    var writeData: PublishSubject<DreamWriteEntity> { get set }
    var writeFail: PublishSubject<Error> { get set }
}

public class DefaultDreamWriteUseCase {
    
    private let repository: DreamWriteRepository
    private let disposeBag = DisposeBag()
    
    public var writeData = PublishSubject<DreamWriteEntity>()
    public var writeFail = PublishSubject<Error>()
    
    public init(repository: DreamWriteRepository) {
        self.repository = repository
    }
}

extension DefaultDreamWriteUseCase: DreamWriteUseCase {
    public func writeDreamRecord(title: String, date: String, content: String, emotion: Int, genre: [Int], note: String?, voice: URL?) {
        self.repository.writeDreamRecord(title: title, date: date, content: content, emotion: emotion, genre: genre, note: note, voice: voice)
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
