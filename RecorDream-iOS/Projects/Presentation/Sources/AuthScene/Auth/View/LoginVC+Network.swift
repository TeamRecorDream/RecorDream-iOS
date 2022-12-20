//
//  LoginVC+Network.swift
//  Presentation
//
//  Created by 정은희 on 2022/12/06.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit
import AuthenticationServices

import Domain
import RD_Core

import KakaoSDKAuth
import KakaoSDKUser

extension LoginVC {
    func kakaoLoginAuthentication() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { [weak self] oauthToken, error in
                guard let self = self else { return }
                self.kakaoLoginRequest(oauthToken, error)
            }
        }
        else {
            UserApi.shared.loginWithKakaoAccount { [weak self] oauthToken, error in
                guard let self = self else { return }
                self.kakaoLoginRequest(oauthToken, error)
            }
        }
    }
    
    func appleLoginAuthentication() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension LoginVC: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    fileprivate func kakaoLoginRequest(_ oauthToken: OAuthToken? = nil, _ error: Error?) {
        guard error == nil else {
            self.loginRequestFail.onNext(.kakao)
            return
        }
        
        guard let kakaoToken = oauthToken?.accessToken else {
            self.loginRequestFail.onNext(.kakao)
            return
        }
        
        let authRequestEntity = AuthRequest(
            kakaoToken: kakaoToken,
            appleToken: nil,
            fcmToken: UserDefaults.standard.string(forKey: UserDefaultKey.userToken.rawValue)!)
        self.loginRequestSuccess.onNext(authRequestEntity)
    }
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
          guard let identityToken = appleIDCredential.identityToken,
                let tokenString = String(data: identityToken, encoding: .utf8) else {
            self.loginRequestFail.onNext(.apple)
            break
          }
            let authRequestEntity = AuthRequest(
                kakaoToken: nil,
                appleToken: tokenString,
                fcmToken: UserDefaults.standard.string(forKey: UserDefaultKey.userToken.rawValue)!)
          self.loginRequestSuccess.onNext(authRequestEntity)
        default:
          break
        }
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
      self.loginRequestFail.onNext(.apple)
    }
}
