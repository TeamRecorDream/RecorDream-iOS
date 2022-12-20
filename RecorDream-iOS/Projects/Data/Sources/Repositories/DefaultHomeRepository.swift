//
//  DefaultHomeRepository.swift
//  
//
//  Created by 김수연 on 2022/10/23.
//

import Foundation

import Domain
import RD_Network

import RxSwift

public class DefaultHomeRepository {
  
    private let disposeBag = DisposeBag()

    public init() {
    
    }
}

extension DefaultHomeRepository: HomeRepository {
    public func fetchDreamRecord() -> Observable<HomeEntity> {
        return Observable.create({ observer in
            observer.onNext(.init(nickname: "수베라",
                                  records: [HomeEntity.Record(recordId: "63727b78afcf86c942603076", emotion: 4, date: "2022/11/15 TUE", title: "오늘은 11월 15일", genres: [.로맨스], content: "코미디코미디"),
                                            HomeEntity.Record(recordId: "638257ca908603b09f0ee04c", emotion: 2, date: "2022/08/26 FRI", title: "꿈에 예리 나왔음", genres: [.코미디,.로맨스], content: "우리집에서 같이 자고 일어났는데 걔가 대만 가고 싶다고 하는거임 그래서 나 갔다왔는데 너무 좋앆다고 하다가 즉흥적으로 같이 비행기 바로 끊는데 예리는 그 전에 다른 친구랑 싱가포르 가기로 했었어서 거기서 바로 온다고 했고 스카이라이너로 예매하길래 오… 연예인도 이런거 쓰는구나 싶어서 신기하다고 생각하다가 깼음")]))
            return Disposables.create()
        })
    }
}
