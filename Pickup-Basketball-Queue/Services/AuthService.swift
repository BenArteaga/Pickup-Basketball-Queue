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
    
    //function to delete the current user
    func deleteCurrentUser() {
        let user = Auth.auth().currentUser
        
        user?.delete { error in
            if let error = error {
                print("user could not be deleted")
            }
            else {
                print("user deleted")
            }
        }
    }
    
    //function which saves whether a user is a gym or player
    func saveGymOrPlayer(in_isGym: Bool) {
        let userID = Auth.auth().currentUser?.uid
        let ref = Database.database().reference().child("gymOrPlayer").child(userID!)
        let isGym = ["isGym": in_isGym]
        ref.updateChildValues(isGym)
    }
    
    //function which retrieves whether a user is a gym or player
    func isGym(in_uid: String, completion: @escaping (Bool) -> Void) {
        let ref = Database.database().reference().child("gymOrPlayer").child(in_uid)
        ref.observeSingleEvent(of: .value, with: { snapshot in
            let isGym = snapshot.value as! Bool
            if isGym {
                completion(true)
            }
            else {
                completion(false)
            }
        })
    }
}
