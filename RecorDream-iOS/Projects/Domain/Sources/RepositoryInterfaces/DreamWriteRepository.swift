//
//  Sample.swift
//  ProjectDescriptionHelpers
//
//  Created by Junho Lee on 2022/09/29.
//

import Foundation

import RxSwift

public protocol DreamWriteRepository {
    func writeDreamRecord(request: DreamWriteRequest) -> Observable<String>
    func fetchDreamRecord(recordId: String) -> Observable<DreamWriteEntity?>
    func modifyDreamRecord(request: DreamWriteRequest, recordId: String) -> Observable<Void>
    func uploadVoice(voiceData: Data) -> Observable<String?>
}
