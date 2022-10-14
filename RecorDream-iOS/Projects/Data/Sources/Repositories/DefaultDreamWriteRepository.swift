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
    public func writeDreamRecord(title: String, date: String, content: String, emotion: Int, genre: [Int], note: String?, voice: URL?) -> Observable<DreamWriteEntity?> {
        return Observable.create { observer in
            self.recordService.writeDreamRecord(title: title, date: date, content: content, emotion: emotion, genre: genre, note: note, voice: voice)
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

