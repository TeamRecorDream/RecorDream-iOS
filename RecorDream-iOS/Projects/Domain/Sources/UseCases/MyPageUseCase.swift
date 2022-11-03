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

    func validateUsernameEdit()
}

public class DefaultMyPageUseCase {
  
    private let repository: MyPageRepository
    private let disposeBag = DisposeBag()
    public var usernameEditStatus = BehaviorRelay<Bool>(value: false)
  
    public init(repository: MyPageRepository) {
        self.repository = repository
    }
}

extension DefaultMyPageUseCase: MyPageUseCase {
  
    public func validateUsernameEdit() {
        let isAlreadyEditing = usernameEditStatus.value
        
        guard !isAlreadyEditing else { return }
        usernameEditStatus.accept(true)
    }
}
