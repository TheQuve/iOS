//
//  SignUpViewController.swift
//  Quve
//
//  Created by ParkSungJoon on 17/01/2019.
//  Copyright © 2019 Park Sung Joon. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var comfirmTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signupButton.addTarget(self, action: #selector(signupButtonAction(_:)), for: .touchUpInside)
    }
    
    @objc private func signupButtonAction(_ sender: UIButton) {
        if let username = emailTextField.text,
           let password = comfirmTextField.text {
            APIClient.register(username: username, password: password) { (result) in
                switch result {
                case .success(let userData):
                    self.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
