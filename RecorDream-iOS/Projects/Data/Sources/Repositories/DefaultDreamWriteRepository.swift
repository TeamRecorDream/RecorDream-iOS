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
    private let voiceService: VoiceService
    
    public init(recordService: RecordService,
                voiceService: VoiceService) {
        self.recordService = recordService
        self.voiceService = voiceService
    }
}

extension DefaultDreamWriteRepository: DreamWriteRepository {
    public func uploadVoice(fileURL: URL) -> RxSwift.Observable<String?> {
        return Observable.create { observer in
            self.voiceService.uploadVoice(fileURL: fileURL)
                .subscribe(onNext: { entity in
                    guard let id = entity?.id else {
                        observer.onNext(nil)
                        return
                    }
                    observer.onNext(id)
                }, onError: { err in
                    observer.onError(err)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    public func fetchDreamRecord(recordId: String) -> Observable<DreamWriteEntity> {
        return Observable.create { observer in
            observer.onNext(.init(main: .init(titleText: "안녕하세요", contentText: "내용입니다", recordTime: "01:24", date: "2022-04-03"),
                                  emotions: [.init(isSelected: false),
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
            guard let title = request.title,
                  let content = request.content,
                  let emotion = request.emotion else { return Disposables.create() }
            self.recordService.writeDreamRecord(title: title, date: request.date, content: content, emotion: emotion, genre: request.genre, note: request.note, voice: request.voice)
                .subscribe(onNext: { _ in
                    observer.onNext(())
                }, onError: { err in
                    observer.onError(err)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}

