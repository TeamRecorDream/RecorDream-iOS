//
//  MockMyPageUseCase.swift
//  PresentationTests
//
//  Created by Junho Lee on 2022/12/13.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

import Foundation

import RxRelay
import RxSwift

@testable import Domain

final class MockMyPageUseCase: MyPageUseCase {
    
    var withdrawalSuccess = PublishSubject<Void>()
    
    var myPageFetched = PublishSubject<MyPageEntity?>()
    
    var logoutSuccess = PublishSubject<Void>()
    
    var withdrawlSuccess = PublishSubject<Void>()
    
    var usernameEditStatus = BehaviorRelay<Bool>(value: false)
    
    var shouldShowAlert = PublishRelay<Void>()
    
    var updatePushSuccess = PublishSubject<String?>()
}

extension MockMyPageUseCase {
    
    func fetchMyPageData() {
        myPageFetched.onNext(MockMyPageUseCase.sampleMyPageInformation)
    }
    
    func validateUsernameEdit() {
        let isAlreadyEditing = usernameEditStatus.value
        
        guard !isAlreadyEditing else { return }
        usernameEditStatus.accept(true)
    }
    
    func restartUsernameEdit() {
        
    }
    
    func startUsernameEdit() {
        
    }
    
    func editUsername(username: String) {
        
    }
    
    func userLogout() {
        
    }
    
    func userWithdrawl() {
        
    }
    
    func disablePushNotice() {
        
    }
    
    func enablePushNotice(time: String) {
        
    }
    
    func userWithdrawal() {
        
    }
}

extension MockMyPageUseCase {
    static let sampleMyPageInformation = MyPageEntity.init(userName: "샘플",
                                                           email: "이메일",
                                                           pushOnOff: true,
                                                           pushTime: nil)
}

extension MyPageEntity: Equatable {
    public static func == (lhs: MyPageEntity, rhs: MyPageEntity) -> Bool {
        return lhs.userName == rhs.userName
        && lhs.pushOnOff == rhs.pushOnOff
        && lhs.email == rhs.email
        && lhs.pushTime == rhs.pushTime
    }
}
