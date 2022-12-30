//
//  DreamDetailMoreUseCase.swift
//  PresentationTests
//
//  Created by 김수연 on 2022/12/30.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

import RxSwift
import RxRelay

public protocol DreamDetailMoreUseCase {

}

public class DefaultDreamDetailMoreUseCase {
  
    private let repository: DreamDetailMoreRepository
    private let disposeBag = DisposeBag()
  
    public init(repository: DreamDetailMoreRepository) {
        self.repository = repository
    }
}

extension DefaultDreamDetailMoreUseCase: DreamDetailMoreUseCase {
  
}
