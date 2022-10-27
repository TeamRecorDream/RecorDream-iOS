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
    public func fetchDreamRecord(recordId: String) -> Observable<DreamWriteEntity> {
        return Observable.create { observer in
            observer.onNext(.init(main: .init(titleText: "안녕하세요", contentText: "내용입니다", recordTime: 35.0, date: "22.04.03"),
                                  emotions: [.init(isSelected: true),
                                             .init(isSelected: false),
                                             .init(isSelected: false),
                                             .init(isSelected: true),
                                             .init(isSelected: false)],
                                  genres: [.init(isSelected: false),
                                           .init(isSelected: false),
                                           .init(isSelected: true),
                                           .init(isSelected: false),
                                           .init(isSelected: false),
                                           .init(isSelected: false),
                                           .init(isSelected: true),
                                           .init(isSelected: true),
                                           .init(isSelected: false),
                                           .init(isSelected: false)],
                                  note: .init(noteText: "노트 샘플 내용")))
            return Disposables.create()
        }
    }
    
    public func writeDreamRecord(request: DreamWriteRequest) -> Observable<Void> {
        return Observable.create { observer in
//            self.recordService.writeDreamRecord(title: request.title, date: request.date, content: request.content, emotion: request.emotion, genre: request.genre, note: request.note, voice: request.voice)
//                .subscribe(onNext: { entity in
//                    guard let entity = entity else { return observer.onCompleted() }
//                    observer.onNext(())
//                }, onError: { err in
//                    observer.onError(err)
//                })
//                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}

