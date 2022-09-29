//
//  DreamWriteRepository.swift
//  RD-Navigator
//
//  Created by Junho Lee on 2022/09/29.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import RxSwift

protocol DreamWriteRepository {
  
}

final class DefaultDreamWriteRepository {
  
    private let disposeBag = DisposeBag()

    init() {
    
    }
}

extension DefaultDreamWriteRepository: DreamWriteRepository {
  
}
