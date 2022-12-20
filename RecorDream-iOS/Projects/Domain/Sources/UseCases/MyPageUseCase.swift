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
    // 회원 정보를 Token으로 요청하기 때문에 파라미터 없음
    func fetchMyPageData()
    func validateUsernameEdit()
    func restartUsernameEditAfterAlert()
    func startUsernameEdit()
    func requestUsernameEdit(username: String)
    func disablePushNotice()
    func enablePushNotice(time: String)
    func userLogout()
    func userWithdrawal()
    
    var myPageFetched: PublishSubject<MyPageEntity?> { get set }
    var logoutOrWithDrawalSuccess: PublishSubject<Bool> { get set }
    var usernameEditStatus: BehaviorRelay<Bool> { get set }
    var shouldShowAlert: PublishRelay<Void> { get set }
    var updatePushSuccess: PublishSubject<String?> { get set }
    var pushTime: String { get set }
}

public class DefaultMyPageUseCase {
    
    private let repository: MyPageRepository
    private let disposeBag = DisposeBag()
    
    public var myPageFetched = PublishSubject<MyPageEntity?>()
    public var usernameEditStatus = BehaviorRelay<Bool>(value: false)
    public var shouldShowAlert = PublishRelay<Void>()
    public var logoutOrWithDrawalSuccess = PublishSubject<Bool>()
    public var updatePushSuccess = PublishSubject<String?>()
    public var pushTime = ""
    
    public init(repository: MyPageRepository) {
        self.repository = repository
    }
}

// MARK: - EditNickname

extension DefaultMyPageUseCase: MyPageUseCase {
    
    /// 이미 닉네임 변경 중인 경우를 필터링하고 닉네임 변경 상태로 전환하는 메서드
    public func validateUsernameEdit() {
        let isAlreadyEditing = usernameEditStatus.value
        
        guard !isAlreadyEditing else { return }
        usernameEditStatus.accept(true)
    }
    
    /// respository에 username 변경 요청
    /// - Parameter username: 변경할 닉네임
    public func requestUsernameEdit(username: String) {
        self.repository.changeUserNickname(nickname: username)
            .withUnretained(self)
            .subscribe { owner, successed in
                guard successed else {
                    owner.startUsernameEdit()
                    return
                }
                owner.stopUsernameEdit()
            }.disposed(by: self.disposeBag)
    }
    
    private func stopUsernameEdit() {
        usernameEditStatus.accept(false)
    }
    
    /// 알러트가 해제되고 강제로 다시 닉네임 변경 상태로 전환하기 위한 메서드
    public func startUsernameEdit() {
        usernameEditStatus.accept(true)
    }
    
    /// Alert를 띄우고 다시 UserName 변경 상태로 전환하는 메서드
    public func restartUsernameEditAfterAlert() {
        usernameEditStatus.accept(true)
        shouldShowAlert.accept(())
    }
}

// MARK: - Push Notice Setting

extension DefaultMyPageUseCase {
    public func enablePushNotice(time: String) {
        self.pushTime = time
        self.repository.enablePushNotice(time: time)
            .withUnretained(self)
            .subscribe { owner, successed in
                guard successed else {
                    owner.updatePushSuccess.onNext(nil)
                    return
                }
                owner.updatePushSuccess.onNext(owner.pushTime)
            }.disposed(by: self.disposeBag)
    }
    
    public func disablePushNotice() {
        self.repository.disablePushNotice()
            .withUnretained(self)
            .subscribe { owner, successed in
                owner.updatePushSuccess.onNext(nil)
            }.disposed(by: self.disposeBag)
    }
}

// MARK: - Logout & Withdrawal

extension DefaultMyPageUseCase {
    public func fetchMyPageData() {
        self.repository.fetchUserInformation()
            .subscribe(onNext: { entity in
                self.myPageFetched.onNext(entity)
            }).disposed(by: self.disposeBag)
    }
    
    public func userLogout() {
        self.repository.userLogout()
            .withUnretained(self)
            .subscribe(onNext: { owner, logoutSuccess in
                owner.logoutOrWithDrawalSuccess.onNext(logoutSuccess)
            }).disposed(by: self.disposeBag)
    }
    
    public func userWithdrawal() {
        self.repository.userWithdrawal()
            .withUnretained(self)
            .subscribe(onNext: { owner, withDrawalSuccess in
                owner.logoutOrWithDrawalSuccess.onNext(withDrawalSuccess)
            }).disposed(by: self.disposeBag)
    }
}
