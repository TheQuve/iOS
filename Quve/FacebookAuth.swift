//
//  FacebookAuth.swift
//  Quve
//
//  Created by ParkSungJoon on 13/01/2019.
//  Copyright © 2019 Park Sung Joon. All rights reserved.
//

import FacebookLogin
import FacebookCore

class FacebookAuth {
    static func isLogin() -> Bool {
        return AccessToken.current != nil
    }
    
    static func signOut() {
        LoginManager().logOut()
    }
    
    static func isValidatedWithUrl(_ url: URL) -> Bool {
        guard let urlScheme = url.scheme else { return false }
        return urlScheme.hasPrefix("fb\(SDKSettings.appId)") && url.host == "authorize"
    }
}
