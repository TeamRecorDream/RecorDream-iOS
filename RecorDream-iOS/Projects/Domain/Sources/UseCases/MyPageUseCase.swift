//
//  MyPageUseCase.swift
//  PresentationTests
//
//  Created by Junho Lee on 2022/10/09.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import RxSwift
import RxRelay

public protocol MyPageUseCase {

}

public class DefaultMyPageUseCase {
  
    private let repository: MyPageRepository
    private let disposeBag = DisposeBag()
  
    public init(repository: MyPageRepository) {
        self.repository = repository
    }
}

extension DefaultMyPageUseCase: MyPageUseCase {
  
}
