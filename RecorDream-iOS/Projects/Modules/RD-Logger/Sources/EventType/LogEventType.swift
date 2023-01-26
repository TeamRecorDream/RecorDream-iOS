//
//  LogEventType.swift
//  RD-Logger
//
//  Created by Junho Lee on 2023/01/22.
//  Copyright © 2023 RecorDream-iOS. All rights reserved.
//

import UIKit

// MARK: - LogEventType

public protocol LogEventType {
    func name() -> String
    func parameters() -> [String: Any]?
}

public enum FirebaseEventType {
    // 1. 앱 최초 실행
    case appFirstOpen // 앱 최초 실행
    
    // 2. 로그인
    case signin(source: LoginSource) // 애플로그인, 카카오로그인
    
    // 3. 탭 전환
    case clickTab(source: TabSource) // 홈 및 보관함 전환
    case clickPlus // 플러스 버튼
    
    // 4. 보관함
    case clickCard // 보관함 카드 탭
    
    // 5. 작성하기
    case closeWriteView // 작성하기 뷰 닫기
    case completeWrite // 작성하기 완료
    
    // 6. 수정하기
    case closeModifyView // 작성하기 뷰 닫기
    
    // 7. 상세보기
    case closeDetailView // 상세보기 뷰 닫기
    
    // 8. 검색하기
    
    // 9. 마이페이지
    
    // 10. 회원 유입 및 이탈
    case enterForeGround // 앱을 백그라운드로 전환한 경우
    case enterFromBackGround // 백그라운드에서 다시 앱으로 돌아오는 경우
    case logout // 로그아웃
    case withdrawal // 회원탈퇴
}

// MARK: - EventName

extension FirebaseEventType: LogEventType {
    public func name() -> String {
        switch self {
        case .appFirstOpen:
            return "firebase_first_open"
        case .signin(source: let source):
            return "signin_click"
        case .clickTab(source: let source):
            return "click_Tab"
        case .clickPlus:
            return "click_Plus"
        case .clickCard:
            return "click_HomeCard"
        case .closeWriteView:
            return "close_WriteView"
        case .completeWrite:
            return "complete_Write"
        case .closeModifyView:
            return "close_ModifyView"
        case .closeDetailView:
            return "close_DetailView"
        case .enterForeGround:
            return "enter_foreground"
        case .enterFromBackGround:
            return "enter_From_BackGround"
        case .logout:
            return "user_logout"
        case .withdrawal:
            return "user_withdrawal"
        }
    }
}

// MARK: - Parameters

public extension FirebaseEventType {    
    public func parameters() -> [String : Any]? {
        var params: [String: Any] = [:]
        switch self {
        case .signin(let loginSource):
            params["loginSource"] = loginSource.rawValue
            
        case .clickTab(let tabSource):
            params["tabSource"] = tabSource.rawValue
            
        default: break
        }
        return params
    }
}

public extension FirebaseEventType {
    public enum LoginSource: String {
        case kakao
        case apple
    }
    
    public enum TabSource: String {
        case home
        case storage
    }
    
    public enum ViewSource: String {
        case login
        case home
        case storage
        case detail
        case write
        case modify
        case search
        case mypage
    }
}
