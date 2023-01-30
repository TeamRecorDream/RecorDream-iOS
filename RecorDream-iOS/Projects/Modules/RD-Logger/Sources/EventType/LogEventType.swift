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
    // 1. 회원가입/로그인
    case clickSignIn(LoginSource) // 로그인
    
    // 2. 탭
    case clickTabBarPlus // 기록하기 플러스 버튼
    case clickTabBar(TabSource) // 탭 전환
    
    // 3. 홈
    
    // 4. 기록하기 && 6. 수정하기 && 10. 푸시알림 -> 작성하기
    case clickDate(WriteSource)
    case clickDateSave(WriteSource)
    case clickDateCancel(WriteSource)
    case clickVoice(WriteSource)
    case clickVoiceRecord(WriteSource)
    case clickVoiceStop(WriteSource)
    case clickVoiceStopX(WriteSource)
    case clickVoiceStopReRecord(WriteSource)
    case clickVoiceStopSave(WriteSource)
    case clickVoiceStopPlay(WriteSource)
    case clickVoiceStopPause(WriteSource)
    case clickTitle(WriteSource)
    case clickContent(WriteSource)
    case clickEmotion(WriteSource, emotion: String)
    case clickGenre(WriteSource, genre: String)
    case clickNote(WriteSource)
    case clickSave(WriteSource)
    case clickExit(WriteSource)
    
    // 5. 기록 상세보기
    
    // 7. 보관함
    case clickStorageSearch
    case clickStorageMypage
    case clickStorageEmotion(emotion: String)
    case clickStorageViewType(type: String)
    case clickStorageDreamCard
    
    // 8. 검색하기
    case clickSearchSearchBar
    case clickSearchDreamCard
    case clickSearchExit
    
    // 9. 마이페이지
    case clickMypageNicknameEdit
    case clickMypagePushToggle(isOn: Bool)
    case clickMypagePushSave
    case clickMypagePushCancel
    case clickMypageTimeSetting
    case clickMypageTimeSettingSave
    case clickMypageTimeSettingCancel
    case clickMypageLogout
    case clickMypageWithdrawal
    case clickMypageWithdrawalPerform
    case clickMypageWithdrawalCancel
    case clickMypageExit
    
    // 10. 푸시알림
    case clickPushNotice
}

// MARK: - EventName

extension FirebaseEventType: LogEventType {
    
    /// EventName을 만들어줍니다
    /// - Returns: '액션_뷰_타겟오브젝트'의 형식의 String을 구성합니다.
    public func name() -> String {
        if let target = target {
            return [action, viewSource, target].joined(separator: "_")
        } else {
            return [action, viewSource].joined(separator: "_")
        }
    }
    
    var nameString: String {
        return String(describing: self)
    }
}

// MARK: - NameGetter

public extension FirebaseEventType {
    
    /// 현재 action은 "클릭"만 존재, 추후 확장 가능성 있음
    var action: String {
        let isClickAction = nameString.contains("click")
        return isClickAction ? "클릭" : ""
    }
    
    /// writeSource는 따로 파라미터를 받아서 return하고, 나머지의 경우 enum의 변수명 앞글자로 ViewSource를 구분
    var viewSource: String {
        if let writeSource = self.writeSource {
            return writeSource
        }
        for view in ViewSource.allCases {
            if self.nameString.contains(view.nameString) {
                return view.rawValue
            }
        }
        return "NoScreen"
    }
    
    private var writeSource: String? {
        switch self {
        case let .clickDate(writeSource),
            let .clickDateSave(writeSource),
            let .clickDateCancel(writeSource),
            let .clickVoice(writeSource),
            let .clickTitle(writeSource),
            let .clickContent(writeSource),
            let .clickEmotion(writeSource, _),
            let .clickGenre(writeSource, _),
            let .clickNote(writeSource),
            let .clickSave(writeSource),
            let .clickExit(writeSource),
            let .clickVoiceRecord(writeSource),
            let .clickVoiceStop(writeSource),
            let .clickVoiceStopX(writeSource),
            let .clickVoiceStopReRecord(writeSource),
            let .clickVoiceStopSave(writeSource),
            let .clickVoiceStopPlay(writeSource),
            let .clickVoiceStopPause(writeSource):
            return writeSource.rawValue
        default: return nil
        }
    }
    
    /// action의 대상이 되는 target
    /// 버튼, 배너, 토글 등
    var target: String? {
        var object: String? = nil
        switch self {
        // 2. 탭
        case .clickTabBarPlus:
            object = "기록하기"
        // 4. 작성하기 && 6.기록하기 && 10. 푸시알림
        case .clickDate(_):
            object = "날짜배너"
        case .clickDateSave(_):
            object = "날짜배너_저장"
        case .clickDateCancel(_):
            object = "날짜배너_취소"
        case .clickVoice(_):
            object = "녹음배너"
        case .clickVoiceRecord:
            object = "녹음배너_녹음"
        case .clickVoiceStop:
            object = "녹음배너_중지"
        case .clickVoiceStopX:
            object = "녹음배너_중지_취소하기"
        case .clickVoiceStopReRecord:
            object = "녹음배너_중지_다시하기"
        case .clickVoiceStopSave:
            object = "녹음배너_중지_저장하기"
        case .clickVoiceStopPlay:
            object = "녹음배너_중지_재생하기"
        case .clickVoiceStopPause:
            object = "녹음배너_중지_재생하기_일시정지"
        case .clickTitle(_):
            object = "제목배너"
        case .clickContent(_):
            object = "본문배너"
        case .clickEmotion(_, _):
            object = "감정아이콘"
        case .clickGenre(_, _):
            object = "장르선택"
        case .clickNote(_):
            object = "노트배너"
        case .clickSave(_):
            object = "저장하기"
        case .clickExit(_):
            object = "나가기"
        // 9. 마이페이지
        case .clickMypageNicknameEdit:
            object = "닉네임수정"
        case .clickMypagePushToggle:
            object = "푸시토글"
        case .clickMypagePushSave:
            object = "푸시On_저장"
        case .clickMypagePushCancel:
            object = "푸시On_취소"
        case .clickMypageTimeSetting:
            object = "시간설정배너"
        case .clickMypageTimeSettingSave:
            object = "시간설정배너_저장"
        case .clickMypageTimeSettingCancel:
            object = "시간설정배너_취소"
        case .clickMypageLogout:
            object = "로그아웃"
        case .clickMypageWithdrawal:
            object = "탈퇴하기"
        case .clickMypageWithdrawalPerform:
            object = "탈퇴하기_탈퇴"
        case .clickMypageWithdrawalCancel:
            object = "탈퇴하기_취소"
        case .clickMypageExit:
            object = "뒤로가기"
        default:
            break
        }
        return object
    }
}

// MARK: - Parameters

public extension FirebaseEventType {    
    func parameters() -> [String : Any]? {
        var params: [String: Any] = [:]
        switch self {
        case let .clickSignIn(loginSource):
            params["loginSource"] = loginSource.rawValue
        case let .clickTabBar(tabSource):
            params["tabSource"] = tabSource.rawValue
        case let .clickEmotion(_, emotion):
            params["emotion"] = emotion
        case let .clickGenre(_, genre):
            params["genre"] = genre
        case let .clickMypagePushToggle(isOn):
            params["isOn"] = isOn
        case let .clickStorageViewType(type):
            params["type"] = type
        default: break
        }
        return params
    }
}

public extension FirebaseEventType {
    enum LoginSource: String {
        case kakao = "kakao"
        case apple = "apple"
    }
    
    enum TabSource: String {
        case home = "홈"
        case storage = "보관함"
    }
    
    enum ViewSource: String, CaseIterable {
        case SignIn = "로그인"
        case TabBar = "탭"
        case Home = "홈"
        case Storage = "보관함"
        case HomeDetail = "기록 상세보기"
        case Write = "기록하기"
        case Modify = "수정하기"
        case Search = "검색하기"
        case Mypage = "마이페이지"
        case PushNotice = "푸시알림"
        
        var nameString: String {
            return String(describing: self)
        }
    }
    
    enum WriteSource: String {
        case write = "작성하기"
        case modify = "수정하기"
        case pushNotice = "푸시알림"
    }
}
