//
//  DreamWriteUseCase.swift
//  RD-Navigator
//
//  Created by Junho Lee on 2022/09/29.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import RxSwift

public protocol DreamWriteUseCase {

}

public class DefaultDreamWriteUseCase {
  
    private let repository: DreamWriteRepository
    private let disposeBag = DisposeBag()
  
    public init(repository: DreamWriteRepository) {
        self.repository = repository
    }
}

extension DefaultDreamWriteUseCase: DreamWriteUseCase {
  
}
