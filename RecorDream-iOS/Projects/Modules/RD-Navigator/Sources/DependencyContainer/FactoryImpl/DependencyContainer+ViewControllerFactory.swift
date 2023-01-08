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
    public func instantiateSpalshVC() -> Presentation.SplashVC {
        let splashVC = SplashVC()
        splashVC.factory = self
        return splashVC
    }
    
    public func instantiateLoginVC() -> Presentation.LoginVC {
        let loginVC = LoginVC()
        let repository = DefaultAuthRepository(authService: self.authService)
        let useCase = DefaultAuthUseCase(repository: repository)
        let viewModel = LoginViewModel(useCase: useCase)
        
        loginVC.factory = self
        loginVC.loginViewModel = viewModel
        return loginVC
    }
}

extension DependencyContainer: MainTabBarControllerFactory {

    public func instantiateMainTabBarController() -> MainTabBarController {
        let mainTabBar = MainTabBarController()
        mainTabBar.viewModel = MainTabBarViewModel()
        mainTabBar.homeVC = self.instantiateHomeVC()
        mainTabBar.storageVC = self.instantiateStorageVC()
        mainTabBar.factory = self
        
        return mainTabBar
    }
    
    public func instantiateHomeVC() -> Presentation.HomeVC {
        let homeVC = HomeVC()
        let repository = DefaultHomeRepository(recordService: self.recordService)
        let useCase = DefaultHomeUseCase(repository: repository)
        let viewModel = HomeViewModel(useCase: useCase)
        
        homeVC.factory = self
        homeVC.viewModel = viewModel
        
        return homeVC
    }

    public func instantiateDetailVC(dreamId: String) -> Presentation.DreamDetailVC {
        let detailVC = DreamDetailVC()
        let repository = DefaultDreamDetailRepository(recordService: self.recordService)
        let useCase = DefaultDreamDetailUseCase(repository: repository)
        let viewModel = DreamDetailViewModel(useCase: useCase, dreamId: dreamId)

        detailVC.factory = self
        detailVC.viewModel = viewModel

        return detailVC
    }

    public func instantiateDetailMoreVC(dreamId: String) -> Presentation.DreamDetailMoreVC {
        let detailMoreVC = DreamDetailMoreVC()
        let repository = DefaultDreamDetailMoreRepository(recordService: self.recordService)
        let useCase = DefaultDreamDetailMoreUseCase(repository: repository)
        let viewModel = DreamDetailMoreViewModel(useCase: useCase, dreamId: dreamId)

        detailMoreVC.factory = self
        detailMoreVC.viewModel = viewModel

        return detailMoreVC
    }
    
    public func instantiateStorageVC() -> Presentation.StorageVC {
        let storageVC = StorageVC()
        let repository = DefaultStorageRepository(recordService: self.recordService)
        let useCase = DefaultDreamStorageUseCase(repository: repository)
        let viewModel = DreamStorageViewModel(useCase: useCase)
        storageVC.factory = self
        storageVC.viewModel = viewModel
        
        return storageVC
    }
    
    
    public func instantiateDreamWriteVC(_ type: DreamWriteViewModel.DreamWriteViewModelType) -> DreamWriteVC {
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
        dreamWriteVC.factory = self
        
        return dreamWriteVC
    }
    
    public func instantiateMyPageVC() -> MyPageVC {
        let repository = DefaultMyPageRepository(authService: self.authService,
                                                 userService: self.userService)
        let useCase = DefaultMyPageUseCase(repository: repository)
        let viewModel = MyPageViewModel(useCase: useCase)
        let myPageVC = MyPageVC()
        myPageVC.viewModel = viewModel
        myPageVC.factory = self
        
        return myPageVC
    }
    
    public func instantiateSearchVC() -> DreamSearchVC {
        let repository = DefaultSearchRepository(recordService: self.recordService)
        let useCase = DefaultDreamSearchUseCase(dreamSearchRepository: repository)
        let viewModel = DreamSearchViewModel(useCase: useCase)
        let dreamSearchVC = DreamSearchVC()
        dreamSearchVC.viewModel = viewModel
        dreamSearchVC.factory = self
        
        return dreamSearchVC
    }
}
