//
//  DefaultDreamDetailMoreRepository.swift
//  PresentationTests
//
//  Created by 김수연 on 2022/12/30.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

import Domain
import RD_Network

import RxSwift
import Foundation
public class DefaultDreamDetailMoreRepository {

    private var recordService: RecordService
    private let disposeBag = DisposeBag()

    public init(recordService: RecordService) {
        self.recordService = recordService
    }
}

extension DefaultDreamDetailMoreRepository: DreamDetailMoreRepository {
    public func deleteRecord(recordId: String) -> Observable<Bool> {
        return Observable.create { observer in
            self.recordService.deleteRecord(recordId: recordId)
                .subscribe(onNext: { deleteSucess in
                    guard deleteSucess else {
                        observer.onNext(false)
                        return
                    }
                    observer.onNext(true)
                }, onError: { err in
                    observer.onError(err)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}
