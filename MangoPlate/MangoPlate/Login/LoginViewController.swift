//
//  LoginViewController.swift
//  MangoPlate
//
//  Created by 김영인 on 2022/03/11.
//

import UIKit

import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class LoginViewController: UIViewController {

    @IBOutlet weak var kakaoBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: 카카오 로그인 버튼 @objc
    @IBAction func kakaoBtnClick(_ sender: Any) {
        // 카카오톡 설치 여부 확인
        if UserApi.isKakaoTalkLoginAvailable() {
            // 카카오톡 로그인 -> API 호출 결과를 클로저로 전달
            loginWithApp()
        } else {
            // 카카오톡 깔려있지 않을 경우, 웹 브라우저로 카카오 로그인
            loginWithWeb()
        }
    }
}

// MARK: 카카오 로그인 구현
extension LoginViewController {
    
    // 카카오톡 앱으로 로그인
    private func loginWithApp() {
        UserApi.shared.loginWithKakaoTalk { ( _ , error) in
            if let error = error {
                print(error)
            } else {
                print("🟨 로그인 성공")
                
                UserApi.shared.me { (user, error) in
                    if let error = error {
                        print(error)
                    } else {
                        self.presentVC()
                    }
                }
            }
        }
    }
    
    // 카카오톡 웹으로 로그인 ✅
    private func loginWithWeb() {
        UserApi.shared.loginWithKakaoAccount { ( _ , error) in
            if let error = error {
                print(error)
            } else {
                print("🟨 로그인 성공")
                
                UserApi.shared.me {(user, error) in
                    if let error = error {
                        print(error)
                    } else {
                        self.presentVC()
                    }
                }
            }
        }
    }
    
    private func presentVC() {
        // storyboard 사용할 땐, 아래와 같이 구현 필수
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
}
