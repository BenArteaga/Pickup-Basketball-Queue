//
//  QueueService.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 7/14/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase.FIRDataSnapshot

class QueueService {
    static let instance = QueueService()
    
    var gymID: String = ""
    
    var courtNum: Int = 0
    
    var queue: [Player] = []
    
    //function that adds the current user to the queue by adding their uid
    func addCurrentUserToQueue() {
        let userID = Auth.auth().currentUser?.uid
        let ref = Database.database().reference().child("courtInfo").child(gymID).child("\(courtNum)").child("queue")
        let newPlayerOnQueue = ["\(queue.count + 1)": userID] as Dictionary<String, AnyObject>
        ref.updateChildValues(newPlayerOnQueue)
    }
    
    func loadQueue(completion: @escaping (Bool) -> Void) {
        let ref = Database.database().reference().child("courtInfo").child(gymID).child("\(courtNum)").child("queue")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let allPlayers = snapshot.children.allObjects as? [DataSnapshot] else {
                return completion(false)
            }
            
            let dispatchGroup = DispatchGroup()
            for playerSnap in allPlayers {
                dispatchGroup.enter()
                DataService.instance.getPlayerforPlayerID(in_playerID: playerSnap.value as! String) { (player) in
                    if let newPlayer = player {
                        self.queue.append(newPlayer)
                    }
                    dispatchGroup.leave()
                }
            }
            
            dispatchGroup.notify(queue: .main, execute: {
                completion(true)
            })
        })
    }
}
