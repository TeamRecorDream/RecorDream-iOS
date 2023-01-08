//
//  DreamShareUseCase.swift
//  Presentation
//
//  Created by 김수연 on 2023/01/08.
//  Copyright © 2023 RecorDream-iOS. All rights reserved.
//

import RxSwift
import RxRelay

public protocol DreamShareUseCase {

}

public class DefaultDreamShareUseCase {
  
    private let repository: DreamShareRepository
    private let disposeBag = DisposeBag()
  
    public init(repository: DreamShareRepository) {
        self.repository = repository
    }
}

extension DefaultDreamShareUseCase: DreamShareUseCase {
  
}
