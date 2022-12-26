//
//  DreamDetailUseCase.swift
//  
//
//  Created by 김수연 on 2022/12/04.
//

import RxSwift
import RxRelay

public protocol DreamDetailUseCase {

}

public class DefaultDreamDetailUseCase {
  
    private let repository: DreamDetailRepository
    private let disposeBag = DisposeBag()
  
    public init(repository: DreamDetailRepository) {
        self.repository = repository
    }
}

extension DefaultDreamDetailUseCase: DreamDetailUseCase {
  
}
