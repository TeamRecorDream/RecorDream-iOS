//
//  BaseService.swift
//  RD-NetworkTests
//
//  Created by Junho Lee on 2022/10/14.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

import RD_Core

import Alamofire
import RxSwift

public class BaseService {
    
    let disposeBag = DisposeBag()
    
    @frozen enum DecodingMode {
        case model
        case message
        case general
    }
    
    public var AFManager: Session {
        return Managers.default
    }
    
    func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, type: T.Type, decodingMode: DecodingMode = .general) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GeneralResponse<T>.self, from: data)
        else { return .pathErr }
        
        switch statusCode {
        case 200..<300:
            
            switch decodingMode {
            case .model:
                return .success(decodedData.data ?? "None-Data")
                
            case .message:
                return .success(decodedData.message ?? "None-Data")
                
            case .general:
                return .success(decodedData)
            }
            
        case 400..<500:
            return .requestErr(decodedData)
            
        case 500:
            return .serverErr
            
        default:
            return .networkFail
        }
    }
    
    func judgeStatusWithEmptyReponse(by statusCode: Int?) -> NetworkResult<Any> {
        guard let statusCode = statusCode else { return .pathErr }
        switch statusCode {
        case 200..<300: return .success(())
        case 400..<500: return .requestErr(())
        case 500:       return .serverErr
        default:        return .networkFail
        }
    }
    
    func requestObject<T: Codable>(_ target: BaseRouter,
                                   type: T.Type,
                                   decodingMode: DecodingMode,
                                   completion: @escaping (NetworkResult<Any>) -> Void) {
        AFManager.request(target).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return}
                let networkResult = self.judgeStatus(by: statusCode, data, type: type, decodingMode: decodingMode)
                completion(networkResult)
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func requestObjectWithEmptyResponse(_ target: BaseRouter,completion: @escaping (NetworkResult<Any>) -> Void) {
        AFManager.request(target).responseData { response in
            completion(self.judgeStatusWithEmptyReponse(by: response.response?.statusCode))
        }
    }
}

// MARK: - RequestWithRx

extension BaseService {
    
    func requestObjectInRx<T: Codable>(_ target: BaseRouter) -> Observable<T?> {
        return Observable<T?>.create { observer in
            self.AFManager.request(target).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let body = try Json.decoder.decode(GeneralResponse<T>.self, from: data)
                        observer.onNext(body.data)
                        observer.onCompleted()
                    }
                    catch let error {
                        observer.onError(error)
                    }
                    
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func requestObjectInRxWithGeneral<T: Codable>(_ target: BaseRouter) -> Observable<GeneralResponse<T>?> {
        return Observable<GeneralResponse<T>?>.create { observer in
            self.AFManager.request(target).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let body = try Json.decoder.decode(GeneralResponse<T>.self, from: data)
                        observer.onNext(body)
                        observer.onCompleted()
                    }
                    catch let error {
                        observer.onError(error)
                    }
                    
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func requestObjectInRxWithEmptyResponse(_ target: BaseRouter) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            self.AFManager.request(target).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let body = try Json.decoder.decode(GeneralResponse<Bool>.self, from: data)
                        guard body.status <= 299 else {
                            observer.onNext(false)
                            observer.onCompleted()
                            return
                        }
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                    catch let error {
                        observer.onError(error)
                    }
                    
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func uploadMultipartInRx<T: Codable>(_ target: BaseRouter) -> Observable<T?> {
        return Observable<T?>.create { observer in
            self.AFManager.uploadMultipart(target: target).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let body = try Json.decoder.decode(GeneralResponse<T>.self, from: data)
                        observer.onNext(body.data)
                        observer.onCompleted()
                    }
                    catch let error {
                        observer.onError(error)
                    }
                    
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func downloadInRx(url: String) -> Observable<String> {
        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("downloadedVoice.m4a")

            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        return Observable<String>.create { observer in
            self.AFManager.download(url, to: destination).response { response in
                if response.error == nil, let path = response.fileURL?.path {
                    observer.onNext(path)
                } else {
                    observer.onError(response.error!)
                }
            }
            return Disposables.create()
        }
    }
}

