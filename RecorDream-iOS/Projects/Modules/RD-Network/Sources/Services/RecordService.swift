//
//  RecordService.swift
//  RD-NetworkTests
//
//  Created by Junho Lee on 2022/10/14.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

import Alamofire
import RxSwift

public protocol RecordService {
    func writeDreamRecord(title: String, date: String, content: String?, emotion: Int?, genre: [Int]?, note: String?, voice: String?) -> Observable<DreamWriteResponse?>
    func searchDreamRecord(query: String) -> Observable<DreamSearchResponse?>
    func fetchStorage(filter: Int) -> Observable<DreamStorageResponse?>
    func fetchModifyRecord(recordId: String) -> Observable<DreamWriteModifyResponse?>
    func modifyRecord(title: String, date: String, content: String?, emotion: Int?, genre: [Int]?, note: String?, voice: String?, recordId: String) -> Observable<Bool>
    func downloadVoiceRecord(url: String) -> Observable<String>
    func fetchHomeRecord() -> Observable<HomeDreamResponse?>
}

public class DefaultRecordService: BaseService {
    public static let shared = DefaultRecordService()

    private override init() {}
}

extension DefaultRecordService: RecordService {
    public func downloadVoiceRecord(url: String) -> RxSwift.Observable<String> {
        downloadInRx(url: url)
    }

    public func modifyRecord(title: String, date: String, content: String?, emotion: Int?, genre: [Int]?, note: String?, voice: String?, recordId: String) -> RxSwift.Observable<Bool> {
        requestObjectInRxWithEmptyResponse(RecordRouter.modifyRecord(title: title, date: date, content: content, emotion: emotion, genre: genre, note: note, voice: voice, recordId: recordId))
    }

    public func writeDreamRecord(title: String, date: String, content: String?, emotion: Int?, genre: [Int]?, note: String?, voice: String?) -> RxSwift.Observable<DreamWriteResponse?> {
        requestObjectInRx(RecordRouter.writeRecord(title: title, date: date, content: content, emotion: emotion, genre: genre, note: note, voice: voice))
    }
    public func searchDreamRecord(query: String) -> RxSwift.Observable<DreamSearchResponse?> {
        requestObjectInRx(RecordRouter.searchRecord(keyword: query))
    }
    public func fetchStorage(filter: Int) -> RxSwift.Observable<DreamStorageResponse?> {
        requestObjectInRx(RecordRouter.fetchStorage(filter: filter))
    }
    public func fetchModifyRecord(recordId: String) -> RxSwift.Observable<DreamWriteModifyResponse?> {
        requestObjectInRx(RecordRouter.fetchModifyRecord(recordId: recordId))
    }
    public func fetchHomeRecord() -> Observable<HomeDreamResponse?> {
        requestObjectInRx(RecordRouter.homeRecord)
    }
}
