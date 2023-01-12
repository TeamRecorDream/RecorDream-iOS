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
    func writeDreamRecord(request: DreamWriteRequest, voiceId: String?)
    func fetchDreamRecord(recordId: String)
    func modifyDreamRecord(request: DreamWriteRequest, voiceId: String?, recordId: String)
    func titleTextValidate(text: String)
    func uploadVoice(voiceData: Data)
    
    var writeSuccess: PublishSubject<String?> { get set }
    var isWriteEnabled: PublishSubject<Bool> { get set }
    var fetchedRecord: PublishSubject<DreamWriteEntity?> { get set }
    var uploadedVoice: PublishSubject<String?> { get set }
}

public class DefaultDreamWriteUseCase {
    
    private let repository: DreamWriteRepository
    private let disposeBag = DisposeBag()
    
    public var writeSuccess = PublishSubject<String?>()
    public var isWriteEnabled = PublishSubject<Bool>()
    public var fetchedRecord = PublishSubject<DreamWriteEntity?>()
    public var uploadedVoice = PublishSubject<String?>()
    
    public init(repository: DreamWriteRepository) {
        self.repository = repository
    }
}

extension DefaultDreamWriteUseCase: DreamWriteUseCase {
    
    public func titleTextValidate(text: String) {
        let existDistinctTitle = (text.count > 0 && text != "꿈의 제목을 남겨주세요")
        self.isWriteEnabled.onNext(existDistinctTitle)
    }
    
    public func fetchDreamRecord(recordId: String) {
        self.repository.fetchDreamRecord(recordId: recordId)
            .withUnretained(self)
            .subscribe(onNext: { strongSelf, entity in
                guard let entity = entity else {
                    strongSelf.fetchedRecord.onNext(nil)
                    return
                }
                strongSelf.fetchedRecord.onNext(entity)
            }).disposed(by: self.disposeBag)
    }
    
    public func writeDreamRecord(request: DreamWriteRequest, voiceId: String?) {
        let validRequest = request.makeValidFileds(voiceId: voiceId)
        self.repository.writeDreamRecord(request: validRequest)
            .withUnretained(self)
            .subscribe(onNext: { strongSelf, recordId in
            strongSelf.writeSuccess.onNext(recordId)
        }).disposed(by: self.disposeBag)
    }
    
    public func modifyDreamRecord(request: DreamWriteRequest, voiceId: String?, recordId: String) {
        let validRequest = request.makeValidFileds(voiceId: voiceId)
        self.repository.modifyDreamRecord(request: validRequest, recordId: recordId)
            .withUnretained(self)
            .subscribe(onNext: { strongSelf, entity in
            strongSelf.writeSuccess.onNext(nil)
        }).disposed(by: self.disposeBag)
    }
    
    public func uploadVoice(voiceData: Data) {
        self.repository.uploadVoice(voiceData: voiceData)
            .withUnretained(self)
            .subscribe(onNext: { strongSelf, voiceId in
                strongSelf.uploadedVoice.onNext(voiceId)
            }).disposed(by: self.disposeBag)
    }
}
