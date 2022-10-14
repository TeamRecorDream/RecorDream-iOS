//
//  Sample.swift
//  ProjectDescriptionHelpers
//
//  Created by Junho Lee on 2022/09/29.
//

import Foundation

import RxSwift

public protocol DreamWriteRepository {
    func writeDreamRecord(request: DreamWriteRequestEntity) -> Observable<DreamWriteEntity?>
}
