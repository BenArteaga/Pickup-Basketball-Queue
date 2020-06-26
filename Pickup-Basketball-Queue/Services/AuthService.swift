//
//  AuthService.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 6/19/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let instance = AuthService()
    
    var email: String?
    var isLoggedIn = false
    var isGym = false
    var firstTime = false
    
    func emailLogin(_ email: String, password: String, completion: @escaping (_ Success: Bool, _ message: String) -> Void) {
        Firebase.Auth.auth().signIn(withEmail: email, password: password, completion: {
            (user, error) in
            if error != nil {
                if let errorCode = Firebase.AuthErrorCode(rawValue: (error?._code)!) {
                    if errorCode == .userNotFound {
                        self.firstTime = true
                        Firebase.Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                completion(false, "Error creating account")
                            }
                            else {
                                completion(true, "Successfully created account")
                            }
                        })
                    }
                    else {
                        if errorCode == .networkError {
                            completion(false, "Sorry it appears you have a network connection error")
                        }
                        else {
                            completion(false, "Sorry, incorrect email or password")
                        }
                    }
                }
            }
            else {
                self.firstTime = false
                completion(true, "Successfully Logged In")
            }
        })
    }
}
