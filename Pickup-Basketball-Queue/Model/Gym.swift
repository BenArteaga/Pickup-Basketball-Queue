//
//  Gym.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 6/26/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import Foundation

class Gym {
    //players will add gyms that they use to their home view
    fileprivate var _gymName: String?
    //number of courts is important because each court will have a seperate queue
    fileprivate var _numOfCourts: Int?
    
    var gymName: String? {
        return _gymName
    }
    
    var numOfCourts: Int? {
        return _numOfCourts
    }
    
    //regular initializer
    init(in_gymName: String?, in_numOfCourts: Int?) {
        _gymName = in_gymName
        _numOfCourts = in_numOfCourts
    }
    
    //initializes from dictionary from Firebase backend
    init(gymData: Dictionary<String, AnyObject>) {
        _gymName = gymData["gym"] as? String
        _numOfCourts = gymData["courtCount"] as? Int
    }
    
    
}
