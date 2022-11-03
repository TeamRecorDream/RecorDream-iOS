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
    func restartUsernameEdit()
    func startUsernameEdit()
    func editUsername(username: String)
    var usernameEditStatus: BehaviorRelay<Bool> { get set }
    var shouldShowAlert: PublishRelay<Void> { get set }
}

public class DefaultMyPageUseCase {
  
    private let repository: MyPageRepository
    private let disposeBag = DisposeBag()
    public var usernameEditStatus = BehaviorRelay<Bool>(value: false)
    public var shouldShowAlert = PublishRelay<Void>()
  
    public init(repository: MyPageRepository) {
        self.repository = repository
    }
}

extension DefaultMyPageUseCase: MyPageUseCase {
  
    // TODO: - repostiory에 요청하고 성공하면 stopUsername 호출
    public func editUsername(username: String) {
        stopUsernameEdit()
    }
    
    public func validateUsernameEdit() {
        let isAlreadyEditing = usernameEditStatus.value
        
        guard !isAlreadyEditing else { return }
        usernameEditStatus.accept(true)
    }
    
    private func stopUsernameEdit() {
        usernameEditStatus.accept(false)
    }
    
    public func startUsernameEdit() {
        usernameEditStatus.accept(true)
    }
    
    public func restartUsernameEdit() {
        usernameEditStatus.accept(true)
        shouldShowAlert.accept(())
    }
}
