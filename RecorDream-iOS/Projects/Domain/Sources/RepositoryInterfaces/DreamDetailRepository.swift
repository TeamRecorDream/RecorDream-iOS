//
//  DreamDetailRepository.swift
//  
//
//  Created by 김수연 on 2022/12/04.
//

import RxSwift

public protocol DreamDetailRepository {
    func fetchDetailRecord(recordId: String) -> Observable<DreamDetailEntity>
}
