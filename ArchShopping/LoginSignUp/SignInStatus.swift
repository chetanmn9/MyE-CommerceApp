//
//  SignInStatus.swift
//  ArchShopping
//
//  Created by Chetan Melkote nagaraj on 26/2/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import Foundation

class loginCheck {
    func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")      //return ture/false based on customer logged in status
    }
}


