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
import AVFoundation

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
    public func uploadVoice(voiceData: Data) -> RxSwift.Observable<String?> {
        return Observable.create { observer in
            self.voiceService.uploadVoice(data: voiceData)
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
    
    public func fetchDreamRecord(recordId: String) -> Observable<DreamWriteEntity?> {
        return Observable.create { observer in
            self.recordService.fetchModifyRecord(recordId: recordId)
                .subscribe(onNext: { response in
                    guard var entity = response?.toDomain() else { return }
                    observer.onNext(entity)
                }, onError: { err in
                    observer.onError(err)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    public func writeDreamRecord(request: DreamWriteRequest) -> Observable<String> {
        return Observable.create { observer in
            guard let title = request.title else { return Disposables.create() }
            self.recordService.writeDreamRecord(title: title, date: request.date, content: request.content, emotion: request.emotion, genre: request.genre, note: request.note, voice: request.voice)
                .subscribe(onNext: { entity in
                    guard let recordId = entity?.id else {
                        observer.onCompleted()
                        return
                    }
                    observer.onNext(recordId)
                }, onError: { err in
                    observer.onError(err)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    public func modifyDreamRecord(request: DreamWriteRequest, recordId: String) -> Observable<Void> {
        return Observable.create { observer in
            guard let title = request.title else { return Disposables.create() }
            self.recordService.modifyRecord(title: title, date: request.date, content: request.content, emotion: request.emotion, genre: request.genre, note: request.note, voice: request.voice, recordId: recordId)
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

