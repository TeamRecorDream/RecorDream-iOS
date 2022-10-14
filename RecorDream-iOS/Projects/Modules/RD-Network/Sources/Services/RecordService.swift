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
    func writeDreamRecord(title: String, date: String, content: String, emotion: Int, genre: [Int], note: String?, voice: URL?) -> Observable<DreamWriteDTO?>
}

public class DefaultRecordService: BaseService {
    public static let shared = DefaultRecordService()
    
    private override init() {}
}

extension DefaultRecordService: RecordService {
    public func writeDreamRecord(title: String, date: String, content: String, emotion: Int, genre: [Int], note: String?, voice: URL?) -> RxSwift.Observable<DreamWriteDTO?> {
        requestObjectInRx(RecordRouter.writeRecord(title: title, date: date, content: content, emotion: emotion, genre: genre, note: note, voice: voice))
    }
}