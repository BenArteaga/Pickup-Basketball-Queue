//
//  CourtService.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 7/8/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase.FIRDataSnapshot

class CourtService {
    static let instance = CourtService()
    //array populated with the all the courts within a particular gym
    var courts: [Court] = []
    
    //function to save all of the courts for a gym when a gym is created
    func saveCourts(in_numCourts: Int) {
        let userID = Auth.auth().currentUser?.uid
        let queue = [Player]()
        //initialize every court that the gym has into the database
        for i in 1...in_numCourts {
            let ref = Database.database().reference().child("courtInfo").child(userID!).child("\(i)")
            let court = ["open": false, "queue": queue] as Dictionary<String, AnyObject>
            ref.updateChildValues(court)
        }
    }
    
    //function to load all of the courts for the current gym that is signed in
    func loadCourts(completion: @escaping (Bool) -> Void) {
        let userID = Auth.auth().currentUser?.uid
        let ref = Database.database().reference().child("courtInfo").child(userID!)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let allCourts = snapshot.children.allObjects as? [DataSnapshot] else {
                return completion(false)
            }
            
            let dispatchGroup = DispatchGroup()
            
            for courtData in allCourts {
                dispatchGroup.enter()
                let court = Court(in_courtNum: Int(courtData.key)!, fbData: courtData.value as! Dictionary<String, AnyObject>)
                self.courts.append(court)
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: .main, execute: {
                completion(true)
            })
        })
    }
}
