//
//  Gym.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 6/26/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase.FIRDataSnapshot
import FirebaseStorage

class Gym {
    fileprivate var _gymID: String?
    //players will add gyms that they use to their home view
    fileprivate var _gymName: String?
    //number of courts is important because each court will have a seperate queue
    fileprivate var _numOfCourts: Int?
    
    var gymID: String? {
        return _gymID
    }
    
    var gymName: String? {
        return _gymName
    }
    
    var numOfCourts: Int? {
        return _numOfCourts
    }
    
    //regular initializer
    init(in_gymID: String?, in_gymName: String?, in_numOfCourts: Int?) {
        _gymID = in_gymID
        _gymName = in_gymName
        _numOfCourts = in_numOfCourts
    }
    
    //initializes from dictionary from Firebase backend
    init(in_gymID: String?, gymData: Dictionary<String, AnyObject>) {
        _gymID = in_gymID
        _gymName = gymData["gym"] as? String
        _numOfCourts = gymData["courtCount"] as? Int
    }
    
    //creates array of gyms from FB data to display on the addGym page
    static func gymArrayFromFBData(fbData: AnyObject) -> [Gym] {
        var gyms = [Gym]()
        if let formattedData = fbData as? Dictionary<String, AnyObject> {
            for (key, gymInfo) in formattedData {
                    let gym = Gym(in_gymID: key, gymData: gymInfo as! Dictionary<String, AnyObject>)
                    if !DataService.instance.isFollowingGym(gymKey: key) {
                        gyms.append(gym)
                }
                    
            }
        }
        return gyms
    }
    
    
    //creates array of gyms that the player is currently following from FB data to be displayed on the Player Dashboard
    static func getGymsFollowing(fbData: AnyObject) -> [Gym] {
        var gyms = [Gym]()
        if let formattedData = fbData as? Dictionary<String, AnyObject> {
            for (key, value) in formattedData {
                let ref = Database.database().reference().child("gyms")
                ref.observeSingleEvent(of: .value, with: { data in
                    if data.value != nil {
                        if let gymData = data.value as? AnyObject {
                            if let gymDict = gymData as? Dictionary<String, AnyObject> {
                                let gym = Gym(in_gymID: key, gymData: gymDict[key] as! Dictionary<String, AnyObject>)
                                gyms.append(gym)
                            }
                        }
                    }
                })
            }
        }
        return gyms
    }
    
}
