//
//  DataTests.swift
//  ProjectDescriptionHelpers
//
//  Created by Junho Lee on 2022/09/18.
//

import XCTest

import Nimble
import RxCocoa
import RxSwift
import RxTest

@testable import Presentation
@testable import Domain
@testable import RD_DSKit

final class MyPageViewModelTest1: XCTestCase {
    
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    var testViewDidLoad: PublishSubject<Void>!
    var editButtonTapped: PublishSubject<Void>!
    var myPageReturnOutput: PublishSubject<MyPageEditableView.EndEditOutput>!
    var usernameAlertDismissed: PublishSubject<Void>!
    var pushSwitchChanged: PublishSubject<Bool>!
    var pushTimePicked: PublishSubject<String>!
    var logoutButtonTapped: PublishSubject<Void>!
    var withdrawlButtonTapped: PublishSubject<Void>!
    
    var myPageUseCase: MyPageUseCase!
    var myPageViewModel: MyPageViewModel!
    var input: MyPageViewModel.Input!
    var output: MyPageViewModel.Output!
    
    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        myPageUseCase = MockMyPageUseCase()
        myPageViewModel = MyPageViewModel(useCase: myPageUseCase)
        
        testViewDidLoad = PublishSubject<Void>()
        editButtonTapped = PublishSubject<Void>()
        myPageReturnOutput = PublishSubject<MyPageEditableView.EndEditOutput>()
        usernameAlertDismissed = PublishSubject<Void>()
        pushSwitchChanged = PublishSubject<Bool>()
        pushTimePicked = PublishSubject<String>()
        logoutButtonTapped = PublishSubject<Void>()
        withdrawlButtonTapped = PublishSubject<Void>()
    }
    
    override func tearDownWithError() throws {
        scheduler = nil
        disposeBag = nil
        myPageUseCase = nil
        myPageViewModel = nil
        
        testViewDidLoad = nil
        editButtonTapped = nil
        myPageReturnOutput = nil
        usernameAlertDismissed = nil
        pushSwitchChanged = nil
        pushTimePicked = nil
        logoutButtonTapped = nil
        withdrawlButtonTapped = nil
    }
    
    func test_check_fetching() {
        input = MyPageViewModel.Input(viewDidLoad: testViewDidLoad.asObservable(),
                                      editButtonTapped: editButtonTapped.asObservable(),
                                      myPageReturnOutput: myPageReturnOutput.asObservable(),
                                      usernameAlertDismissed: usernameAlertDismissed.asObservable(),
                                      pushSwitchChagned: pushSwitchChanged.asObservable(),
                                      pushTimePicked: pushTimePicked.asObservable(),
                                      logoutButtonTapped: logoutButtonTapped.asObservable(),
                                      withdrawalButtonTapped: withdrawlButtonTapped.asObservable())
        
        output = myPageViewModel.transform(from: input, disposeBag: disposeBag)
        
        let fetchedDataOutput = scheduler.createObserver(MyPageEntity?.self)
        
        scheduler.createColdObservable([
            .next(3, Void())
        ])
        .bind(to: testViewDidLoad)
        .disposed(by: disposeBag)
        
        output.myPageDataFetched
            .subscribe(fetchedDataOutput)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        expect(fetchedDataOutput.events).to(
            equal([.next(0, nil),
                   .next(3, MockMyPageUseCase.sampleMyPageInformation)]),
            description: "failed - UseCase에서 제공한 데이터와 일치하지 않음"
        )
    }
}
