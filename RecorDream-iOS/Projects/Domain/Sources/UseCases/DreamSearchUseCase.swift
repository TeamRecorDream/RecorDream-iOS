//
//  DreamSearchUseCase.swift
//  DomainTests
//
//  Created by 정은희 on 2022/11/09.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

import RD_Core

protocol DreamSearchUseCase {
    func execute(requestValue: DreamSearchUseCaseRequestValue,
                 completion: @escaping (Result<DreamSearchEntity, Error>) -> Void) -> Cancellable?
}

final class DefaultDreamSearchUseCase: DreamSearchUseCase {
    
    private let dreamSearchRepository: DreamSearchRepository

    init(dreamSearchRepository: DreamSearchRepository) {
        self.dreamSearchRepository = dreamSearchRepository
    }

    func execute(requestValue: DreamSearchUseCaseRequestValue,
                 completion: @escaping (Result<DreamSearchEntity, Error>) -> Void) -> Cancellable? {
        return dreamSearchRepository.fetchDreamSearchList(query: requestValue.query) { result in
            completion(result)
        }
    }
}

struct DreamSearchUseCaseRequestValue {
    let query: DreamSearchQuery
}
