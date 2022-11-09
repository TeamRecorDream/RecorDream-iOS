//
//  SearchService.swift
//  RD-Network
//
//  Created by 정은희 on 2022/11/08.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

import Alamofire

public protocol SearchService {
    func searchDreamRecords(keyword: String) throws -> DreamSearchResponse
}

public class DefaultSearchService: BaseService {
    public static let shared = DefaultSearchService()
    
    private override init() { }
}

extension DefaultSearchService: SearchService {
    public func searchDreamRecords(keyword: String) throws -> DreamSearchResponse {
        AFManager.request(SearchRouter.searchRecord(keyword: keyword))
            .responseData { response in
                
            }
    }
}
