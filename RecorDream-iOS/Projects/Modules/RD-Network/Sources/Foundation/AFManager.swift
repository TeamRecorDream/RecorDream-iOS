//
//  AFManager.swift
//  RD-NetworkTests
//
//  Created by Junho Lee on 2022/10/14.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

import Alamofire

class Managers {
    
    static let `default`: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = NetworkEnvironment.requestTimeOut
        configuration.timeoutIntervalForResource = NetworkEnvironment.resourceTimeOut
        let eventLogger = APIEventLogger()
        let interceptor = AlamoInterceptor()
        let session = Session(configuration: configuration, interceptor: interceptor, eventMonitors: [eventLogger])
        return session
    }()

    private init() { }
}

public extension Session {
    func uploadMultipart(target: BaseRouter) -> UploadRequest {
        return self.upload(multipartFormData: target.multipart, with: target)
    }
}
