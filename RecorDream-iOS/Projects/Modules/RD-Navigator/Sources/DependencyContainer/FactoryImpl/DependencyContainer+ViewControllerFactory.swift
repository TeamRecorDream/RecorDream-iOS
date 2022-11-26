//
//  AuthViewControllerFactoryImpl.swift
//  RouterCoordinator
//
//  Created by Junho Lee on 2022/09/29.
//

import UIKit

import Presentation
import Domain
import Data

/*
 ViewControllerFactory 프로토콜을 채택하여 ViewController를 생성할 수 있도록 합니다.
 클린 아키텍쳐에서의 의존성 주입도 담당합니다.
 */
extension DependencyContainer: AuthViewControllerFactory {
    
}

extension DependencyContainer: MainTabBarControllerFactory {
    func instantiateMainTabBarController() -> MainTabBarController {
        let mainTabBar = MainTabBarController()
        mainTabBar.viewModel = MainTabBarViewModel()
        
        return mainTabBar
    }
    
    func instantiateDreamWriteVC(_ type: DreamWriteViewModel.DreamWriteViewModelType) -> DreamWriteVC {
        let repository = DefaultDreamWriteRepository(recordService: self.recordService,
                                                     voiceService: self.voiceService)
        let useCase = DefaultDreamWriteUseCase(repository: repository)
        var viewModel: DreamWriteViewModel
        switch type {
        case .write:
            viewModel = DreamWriteViewModel(useCase: useCase, viewModelType: .write)
        case .modify(let postId):
            viewModel = DreamWriteViewModel(useCase: useCase, viewModelType: .modify(postId: postId))
        }
        let dreamWriteVC = DreamWriteVC()
        dreamWriteVC.viewModel = viewModel
        
        return dreamWriteVC
    }
    
    func instantiateMyPageVC() -> MyPageVC {
        let repository = DefaultMyPageRepository()
        let useCase = DefaultMyPageUseCase(repository: repository)
        let viewModel = MyPageViewModel(useCase: useCase)
        let myPageVC = MyPageVC()
        myPageVC.viewModel = viewModel
        
        return myPageVC
    }
    
    // MARK: - Examples
    // 아래에 예시를 첨부합니다
//    func makeFeedListVC(isMyPage: Bool) -> FeedListVC {
//      let feedRepository = DefaultFeedListRepository(service: BaseService.default)
//      let myPageRepository = DefaultMyPageRepository(service: BaseService.default)
//      let useCase = DefaultFeedListUseCase(
//        myPageRepository: myPageRepository,
//        feedrepository: feedRepository)
//      let viewModel = FeedListViewModel(useCase: useCase,
//                                        isMyPage: isMyPage)
//      let feedListVC =  FeedListVC.controllerFromStoryboard(.feedList)
//      feedListVC.viewModel = viewModel
//      return feedListVC
//    }
//
//    func makeFeedReportVC(isMyPage: Bool) -> FeedReportVC {
//      let repository = DefaultFeedReportRepository()
//      let useCase = DefaultFeedReportUseCase(repository: repository)
//      let viewModel = FeedReportViewModel(useCase: useCase, isMyPage: isMyPage)
//      let feedReportVC = FeedReportVC.controllerFromStoryboard(.feedReport)
//      feedReportVC.viewModel = viewModel
//      return feedReportVC
//    }
}
