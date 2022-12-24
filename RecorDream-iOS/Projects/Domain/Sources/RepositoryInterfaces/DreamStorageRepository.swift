//
//  DreamStorageRepository.swift
//  Domain
//
//  Created by 정은희 on 2022/12/24.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

import RxSwift

public protocol DreamStorageRepository {
    func requestStorageFetch(filter: StorageRequest) -> Observable<StorageEntity?>
}
