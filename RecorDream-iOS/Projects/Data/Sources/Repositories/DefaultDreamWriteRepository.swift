//
//  DreamWriteRepository.swift
//  RD-Navigator
//
//  Created by Junho Lee on 2022/09/29.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

import Domain
import RD_Network

import RxSwift

public class DefaultDreamWriteRepository {
    
    private let disposeBag = DisposeBag()
    
    private let recordService: RecordService
    
    public init(recordService: RecordService) {
        self.recordService = recordService
    }
}

extension DefaultDreamWriteRepository: DreamWriteRepository {
    public func writeDreamRecord(request: DreamWriteRequestEntity) -> Observable<DreamWriteEntity?> {
        return Observable.create { observer in
            self.recordService.writeDreamRecord(title: request.title, date: request.date, content: request.content, emotion: request.emotion, genre: request.genre, note: request.note, voice: request.voice)
                .subscribe(onNext: { entity in
                    guard let entity = entity else { return observer.onCompleted() }
                    observer.onNext(entity.toDomain())
                }, onError: { err in
                    observer.onError(err)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}

