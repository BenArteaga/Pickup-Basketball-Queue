//
//  Court.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 7/8/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import Foundation

class Court {
    fileprivate var _queueOpen: Bool
    fileprivate var _courtNum: Int
    fileprivate var _queue: [Player]
    
    var queueOpen: Bool {
        return _queueOpen
    }
    
    var courtNum: Int {
        return _courtNum
    }
    
    var queue: [Player] {
        return _queue
    }
    
    //regular initializer
    init(in_queueOpen: Bool, in_courtNum: Int, in_queue: [Player]) {
        _queueOpen = in_queueOpen
        _courtNum = in_courtNum
        _queue = in_queue
    }
    
    //initializer using firebase data
    init(in_courtNum: Int, fbData: Dictionary<String, AnyObject>) {
        _courtNum = in_courtNum
        _queueOpen = fbData["open"] as! Bool
        _queue = fbData["queue"] as? [Player] ?? [Player]()
    }
}
