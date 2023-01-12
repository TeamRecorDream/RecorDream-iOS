//
//  Interceptor.swift
//  RD-NetworkTests
//
//  Created by Junho Lee on 2022/10/14.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_Core

import Alamofire

public class AlamoInterceptor: RequestInterceptor {
    
    public typealias AdapterResult = Swift.Result<URLRequest, Error>
    
    private var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    private var alertAlreadySet: Bool = false
    
    // TODO: - 네트워크 에러 팝업 로직
//    func adapt(_ urlRequest: URLRequest, for session: Alamofire.Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
//        if !isConnectedToInternet && !alertAlreadySet {
//            self.showNetworkErrorAlert {
//                completion(.success(urlRequest))
//            }
//        } else {
//            completion(.success(urlRequest))
//        }
//    }
    
    public func retry(_ request: Alamofire.Request, for session: Alamofire.Session, dueTo error: Swift.Error, completion: @escaping (RetryResult) -> Void) {
        // token 재발급 API가 아니며 && 토큰이 만료된 경우(402)
        guard let pathComponents = request.request?.url?.pathComponents,
              !pathComponents.contains("token"),
              let response = request.task?.response as? HTTPURLResponse,
              response.statusCode == 402 else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        // 유효한 토큰의 경우
        guard response.statusCode != 403 else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        DefaultAuthService.shared.reissuance { reissuanceSuccessed in
            if reissuanceSuccessed {
                print("토큰 갱신 성공: ", request.request?.url)
                completion(.retry)
            } else {
                print("토큰 갱신 실패: ", request.request?.url)
                completion(.doNotRetryWithError(error))
            }
        }
    }
    
    private func showNetworkErrorAlert(completion: @escaping (()->Void)) {
        alertAlreadySet = true
        DispatchQueue.main.async {
            let rootViewController = UIApplication.getMostTopViewController()
            rootViewController?.makeAlert(title: "네트워크 에러", message: "네트워크 연결 상태를 확인해주세요") { _ in
                completion()
                self.alertAlreadySet = false
            }
        }
    }
}
