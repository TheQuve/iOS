//
//  GoogleAuth.swift
//  Quve
//
//  Created by ParkSungJoon on 13/01/2019.
//  Copyright © 2019 Park Sung Joon. All rights reserved.
//

import GoogleSignIn

class GoogleAuth {
    
    static func getInstance() -> GIDSignIn {
        return GIDSignIn.sharedInstance()
    }
    
    static func isLogin() -> Bool {
        return getInstance().hasAuthInKeychain()
    }
    
    static func signOut() {
        getInstance().signOut()
    }
    
    static func isValidatedWithUrl(_ url: URL) -> Bool {
        guard let urlScheme = url.scheme else { return false }
        return urlScheme.hasPrefix(Bundle.main.bundleIdentifier!) || urlScheme.hasPrefix("com.googleusercontent.apps.")
    }
}
