//
//  DefaultDreamDetailRepository.swift
//  
//
//  Created by 김수연 on 2022/12/04.
//

import Domain
import RD_Network

import RxSwift
import Foundation

public class DefaultDreamDetailRepository {

    private var recordService: RecordService
    private let disposeBag = DisposeBag()

    public init(recordService: RecordService) {
        self.recordService = recordService
    }
}

extension DefaultDreamDetailRepository: DreamDetailRepository {
    public func fetchDetailRecord(recordId: String) -> Observable<DreamDetailEntity> {
        return Observable.create { observer in

            var tempResponse: DetailDreamResponse?
            var audioFileUrl: URL?

            self.recordService.fetchDetailRecord(recordId: recordId)
                .do(onNext: { response in

                    tempResponse = response
                    
                    guard let entity = response?.toDomain() else {
                        return
                    }
                    guard tempResponse?.voice?.url != nil else {
                        observer.onNext(entity)
                        return
                    }

                })
                .compactMap { $0?.voice?.url }
                .flatMap { self.recordService.downloadVoiceRecord(url: $0) }
                .do(onNext: { fileURL in

                    audioFileUrl = URL.init(string: fileURL)

                })
                .subscribe(onNext: { response in

                    guard var entity = tempResponse?.toDomain() else { return }
                    entity.voiceUrl = audioFileUrl!
                    observer.onNext(entity)

                }, onError: { err in
                    observer.onError(err)
                }).disposed(by: self.disposeBag)

            return Disposables.create()
        }
    }
}
