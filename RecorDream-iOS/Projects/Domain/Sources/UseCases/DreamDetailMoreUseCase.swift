//
//  DreamDetailMoreUseCase.swift
//  PresentationTests
//
//  Created by 김수연 on 2022/12/30.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

import RxSwift
import RxRelay

public protocol DreamDetailMoreUseCase {
    func deleteRecord(recordId: String)

    var deleteRecordSuccess: PublishSubject<Bool> { get set }
}

public class DefaultDreamDetailMoreUseCase {
  
    private let repository: DreamDetailMoreRepository
    private let disposeBag = DisposeBag()

    public var deleteRecordSuccess = PublishSubject<Bool>()
  
    public init(repository: DreamDetailMoreRepository) {
        self.repository = repository
    }
}

extension DefaultDreamDetailMoreUseCase: DreamDetailMoreUseCase {
    public func deleteRecord(recordId: String) {
        self.repository.deleteRecord(recordId: recordId)
            .withUnretained(self)
            .subscribe(onNext: { owner, deleteRecordSuccess in
                owner.deleteRecordSuccess.onNext(deleteRecordSuccess)
            }).disposed(by: self.disposeBag)
    }
}
