//
//  SearchService.swift
//  RD-Network
//
//  Created by 정은희 on 2022/11/08.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

import Alamofire
import RxSwift

public protocol SearchService {
    func searchDreamRecords(keyword: String) -> Observable<DreamSearchResponse?>
}

public class DefaultSearchService: BaseService {
    public static let shared = DefaultSearchService()
    
    private override init() { }
}

extension DefaultSearchService: SearchService {
    public func searchDreamRecords(keyword: String) -> RxSwift.Observable<DreamSearchResponse?> {
        requestObjectInRx(SearchRouter.searchRecord(keyword: keyword))
    }
    
    
}
