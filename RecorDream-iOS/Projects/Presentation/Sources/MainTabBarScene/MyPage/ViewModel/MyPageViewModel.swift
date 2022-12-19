//
//  MyPageViewModel.swift
//  PresentationTests
//
//  Created by Junho Lee on 2022/10/09.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Domain
import RD_Core
import RD_DSKit

import RxSwift
import RxCocoa

public class MyPageViewModel: ViewModelType {
    
    private let useCase: MyPageUseCase
    private let disposeBag = DisposeBag()
    
    // MARK: - Inputs
    
    public struct Input {
        let viewDidLoad: Observable<Void>
        let editButtonTapped: Observable<Void>
        let myPageReturnOutput: Observable<MyPageEditableView.EndEditOutput>
        let usernameAlertDismissed: Observable<Void>
        let pushSwitchChagned: Observable<Bool>
        let pushTimePicked: Observable<String>
        let logoutButtonTapped: Observable<Void>
        let withdrawalButtonTapped: Observable<Void>
    }
    
    // MARK: - Outputs
    
    public struct Output {
        var myPageDataFetched = BehaviorRelay<MyPageEntity?>(value: nil)
        var startUsernameEdit = PublishRelay<Bool>()
        var showAlert = PublishRelay<Void>()
        var usernameEditCompleted = PublishRelay<Bool>()
        var loadingStatus = BehaviorRelay<Bool>(value: true)
        var selectedPushTime = PublishRelay<String?>()
        var popToSplash = PublishRelay<Void>()
    }
    
    // MARK: - Coordination
    
    public init(useCase: MyPageUseCase) {
        self.useCase = useCase
    }
}

extension MyPageViewModel {
    public func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        self.bindOutput(output: output, disposeBag: disposeBag)
        
        input.viewDidLoad.subscribe(onNext: { _ in
            self.useCase.fetchMyPageData()
        }).disposed(by: disposeBag)
        
        input.editButtonTapped.subscribe(onNext: { _ in
            self.useCase.validateUsernameEdit()
        }).disposed(by: disposeBag)
        
        input.myPageReturnOutput.subscribe(onNext: { editOutput in
            switch editOutput {
            case .noText:
                self.useCase.restartUsernameEdit()
            case .endWithProperText(let text):
                output.loadingStatus.accept(true)
                self.useCase.editUsername(username: text)
            }
        }).disposed(by: disposeBag)
        
        input.usernameAlertDismissed.subscribe { _ in
            self.useCase.startUsernameEdit()
        }.disposed(by: disposeBag)
        
        input.pushSwitchChagned
            .filter { $0 == false }
            .subscribe(onNext: { _ in
                self.useCase.disablePushNotice()
        }).disposed(by: disposeBag)
        
        input.pushTimePicked.subscribe(onNext: { selectedTime in
            self.useCase.enablePushNotice(time: selectedTime)
        }).disposed(by: disposeBag)
        
        input.logoutButtonTapped.subscribe(onNext: { _ in
            self.useCase.userLogout()
        }).disposed(by: disposeBag)
        
        input.withdrawalButtonTapped.subscribe(onNext: { _ in
            self.useCase.userWithdrawal()
        }).disposed(by: disposeBag)
        
        return output
    }
    
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
        let myPageData = self.useCase.myPageFetched
        myPageData
            .compactMap { $0 }
            .subscribe(onNext: { entity in
                output.myPageDataFetched.accept(entity)
            }).disposed(by: disposeBag)
        
        let startUsernameEdit = self.useCase.usernameEditStatus
        startUsernameEdit
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {
                output.startUsernameEdit.accept($0)
            }).disposed(by: disposeBag)
        
        let showUsernameWarningAlert = self.useCase.shouldShowAlert
        showUsernameWarningAlert
            .subscribe(onNext: { entity in
                output.showAlert.accept(())
            }).disposed(by: disposeBag)
                
        let logoutOrWithDrawalSuccessed = self.useCase.logoutOrWithDrawalSuccess
        logoutOrWithDrawalSuccessed
            .bind { success in
                output.loadingStatus.accept(false)
                guard success else { return }
                output.popToSplash.accept(())
            }.disposed(by: disposeBag)
        
        let pushUpdateSuccess = self.useCase.updatePushSuccess
        pushUpdateSuccess
            .bind { selectedTime in
                output.loadingStatus.accept(false)
                output.selectedPushTime.accept(selectedTime)
            }.disposed(by: disposeBag)
    }
}
