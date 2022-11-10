//
//  HomeUseCase.swift
//  
//
//  Created by 김수연 on 2022/10/23.
//

import RxSwift
import RxRelay

public protocol HomeUseCase {

}

public class DefaultHomeUseCase {
  
    private let repository: HomeRepository
    private let disposeBag = DisposeBag()
  
    public init(repository: HomeRepository) {
        self.repository = repository
    }
}

extension DefaultHomeUseCase: HomeUseCase {
  
}
