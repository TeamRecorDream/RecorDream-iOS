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

class AlamoInterceptor: RequestInterceptor {
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
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let pathComponents = request.request?.url?.pathComponents,
              !pathComponents.contains("token"),
              let response = request.task?.response as? HTTPURLResponse,
              response.statusCode == 401 else {
            completion(.doNotRetryWithError(error))
            return
        }

        // TODO: - 토큰 재발급 로직 추가
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
