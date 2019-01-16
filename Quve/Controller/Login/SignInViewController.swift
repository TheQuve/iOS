//
//  SignInViewController.swift
//  Quve
//
//  Created by ParkSungJoon on 03/01/2019.
//  Copyright © 2019 Park Sung Joon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import GoogleSignIn
import FacebookCore
import FacebookLogin

class SignInViewController: UIViewController, GIDSignInUIDelegate {

    let disposeBag = DisposeBag()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var facebookLoginButton: UIButton!
    
    private let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.uiDelegate = self
        facebookLoginButton.addTarget(self, action: #selector(facebookLoginButtonAction), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(pressLoginButton(_:)), for: .touchUpInside)
        addValidations()
    }
    
    private func loginByFacebook(_ accessToken: (grantedPermissions: Set<Permission>, declinedPermissions: Set<Permission>, token: AccessToken)) {
        APIClient.facebook(accessToken: accessToken.token.authenticationToken, completion: { (result) in
            switch result {
            case .success(let userData):
                let token = userData.token
                self.ud.setValue(token, forKey: "token")
                self.ud.synchronize()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    @objc private func facebookLoginButtonAction() {
        let facebookManager = LoginManager()
        facebookManager.logIn(readPermissions: [.publicProfile], viewController: self) { loginResult in
            switch loginResult {
            case .success(let accessToken):
                self.loginByFacebook(accessToken)
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            }
        }
    }
    
    @objc private func pressLoginButton(_ sender: UIButton) {
        let email = emailTextField.text
        let password = passwordTextField.text
        APIClient.login(username: email!, password: password!) { (result) in
            switch result {
            case .success(let userData):
                guard let token = userData.token else { return }
                self.ud.setValue(token, forKey: "token")
                self.ud.synchronize()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension SignInViewController {
    
    private func addValidations() {
        let emailEmptyObservable = emailTextField.rx.text.asObservable().map { $0?.isEmpty }
        let passwordEmptyObservable = passwordTextField.rx.text.asObservable().map { $0?.isEmpty }
        
        Observable.combineLatest(emailEmptyObservable, passwordEmptyObservable) {
            return ($0, $1)
            }
            .subscribe(onNext: { (tuple) in
                let buttonTitle: String = {
                    switch tuple {
                    case (true, true): return "이메일과 패스워드를 입력하세요."
                    case (true, false): return "이메일을 입력하세요."
                    case (false, true): return "패스워드를 입력하세요."
                    default: return "로그인하기"
                    }
                }()
                self.loginButton.setTitle(buttonTitle, for: .normal)
                self.loginButton.backgroundColor = tuple.0! || tuple.1! ?  #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1) : #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            })
            .disposed(by: disposeBag)
        
        emailTextField.rx.text.asObservable()
            .map { $0!.isEmpty }
            .subscribe {
                self.emailTextField.backgroundColor = $0.element! ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            }
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.asObservable()
            .map { !(1..<6 ~= $0!.count) }
            .subscribe {
                self.passwordTextField.backgroundColor = $0.element! ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            }
            .disposed(by: disposeBag)
    }
}
