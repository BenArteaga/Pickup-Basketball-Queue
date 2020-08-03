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
    fileprivate var _queueSize: Int
    
    var queueOpen: Bool {
        return _queueOpen
    }
    
    var courtNum: Int {
        return _courtNum
    }
    
    var queueSize: Int {
        return _queueSize
    }
    
    //regular initializer
    init(in_queueOpen: Bool, in_courtNum: Int, in_queueSize: Int) {
        _queueOpen = in_queueOpen
        _courtNum = in_courtNum
        _queueSize = in_queueSize
    }
    
    //initializer using firebase data
    init(in_courtNum: Int, fbData: Dictionary<String, AnyObject>) {
        _courtNum = in_courtNum
        _queueOpen = fbData["open"] as! Bool
        _queueSize = fbData["queueSize"] as? Int ?? 0
    }
}
