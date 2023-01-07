//
//  DreamStorageRepository.swift
//  Domain
//
//  Created by 정은희 on 2022/12/27.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

import RD_Core

import RxSwift

public protocol DreamStorageRepository {
    func fetchDreamStorage(query: StorageFetchQuery) -> Observable<DreamStorageEntity.RecordList?>
}
