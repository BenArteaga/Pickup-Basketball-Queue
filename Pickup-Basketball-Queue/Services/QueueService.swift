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
        
        //update the queue position in the players section of the backend
        let playerRef = Database.database().reference().child("players").child(userID!)
        let newPosition = ["position": queue.count + 1] as Dictionary<String, AnyObject>
        playerRef.updateChildValues(newPosition)
    }
    
    func removeCurrentUserFromQueue(completion: @escaping (Bool) -> Void) {
        let userID = Auth.auth().currentUser?.uid
        var ref = Database.database().reference().child("courtInfo").child(gymID).child("\(courtNum)").child("queue")
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        DataService.instance.getPlayerforPlayerID(in_playerID: userID!) { (player) in

            let queueRemoveData = ["\(player?.queuePosition ?? 0)": NSNull()]
            ref.updateChildValues(queueRemoveData)
            
            //set the queuePosition for that player back to -1, symbolizing that they are no longer on the queue
            let playerRef = Database.database().reference().child("players").child(userID!)
            let queuePositionData = ["position": -1]
            playerRef.updateChildValues(queuePositionData)
        }
        
        dispatchGroup.notify(queue: .main, execute: {
            completion(true)
        })
    }
    
    //function that loads the current queue
    func loadQueue(completion: @escaping (Bool) -> Void) {
        let ref = Database.database().reference().child("courtInfo").child(gymID).child("\(courtNum)").child("queue")
        ref.observe(.value, with: { (snapshot) in
            self.queue.removeAll()
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
                //sort the queue to ensure that it will appear in order
                self.queue = self.queue.sorted(by: {$0.queuePosition! < $1.queuePosition!})
                
                //for some reason, this is getting called twice when removeCurrentUser is called so we need to remove repeats
                var newQueue : [Player] = []
                if self.queue.count > 1 {
                    newQueue.append(self.queue[0])
                    for i in 1..<(self.queue.count) {
                        if(self.queue[i].playerID != self.queue[i - 1].playerID) {
                            newQueue.append(self.queue[i])
                        }
                    }
                    self.queue = newQueue
                }
                //update the size of the queue in the database so that the view with the courts can accurately display queue sizes
                self.updateQueueSize()
                completion(true)
            })
        })
    }
    
    //function to check whether or not the current user is already on the queue
    func isOnQueue(completion: @escaping (Bool) -> Void) {
        let userID = Auth.auth().currentUser?.uid
        let ref = Database.database().reference().child("players").child(userID!)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let playerDict = snapshot.value as! Dictionary<String, AnyObject>
            if playerDict["position"] as! Int == -1 {
                completion(false)
            }
            else {
                completion(true)
            }
        })
    }
    
    func updateQueueSize() {
        let ref = Database.database().reference().child("courtInfo").child(gymID).child("\(courtNum)")
        let newSize = ["queueSize": self.queue.count]
        ref.updateChildValues(newSize)
    }
}
