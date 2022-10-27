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
    func fetchDreamRecord(postId: String)
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
    public var writeFail = PublishSubject<Error>()
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
    public func fetchDreamRecord(postId: String) {
        self.fetchedRecord.onNext(.init(main: .init(titleText: "안녕하세요", contentText: "내용입니다", recordTime: 35.0, date: "22.04.03"),
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
                                        note: .init(noteText: "여기다")))
    }
    
    public func writeDreamRecord(request: DreamWriteRequest) {
        print(request)
//        self.repository.writeDreamRecord(request: request)
//            .subscribe(onNext: { [weak self] entity in
//            guard let self = self else { return }
//            self.writeSuccess.onNext(())
//        }, onError: { err in
//            self.writeFail.onNext(err)
//        }).disposed(by: self.disposeBag)
    }
}
