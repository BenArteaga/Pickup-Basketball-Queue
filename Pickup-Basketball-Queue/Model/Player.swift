//
//  Player.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 6/18/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import Foundation

class Player {
    fileprivate var _playerId: String
    fileprivate var _userId: String?
    fileprivate var _queuePosition: Int?
    fileprivate var _imagePath: String?
    
    var playerId: String {
        return _playerId
    }
    
    var userId: String? {
        return _userId
    }
    
    var queuePosition: Int? {
        return _queuePosition
    }
    
    var imagePath: String? {
        return _imagePath
    }
    
    //regular initializer
    init(in_playerId: String, in_userId: String?, in_queuePosition: Int?, in_imagePath: String?) {
        _playerId = in_playerId
        _userId = in_userId
        _queuePosition = in_queuePosition
        _imagePath = in_imagePath
    }
    
    //initializes instance of a player by using firebase data in the form of a dictionary
    init(in_playerId: String, playerData: Dictionary<String, AnyObject>) {
        _playerId = in_playerId
        _userId = playerData["user"] as? String
        _queuePosition = playerData["position"] as? Int
        _imagePath = playerData["image"] as? String
    }
    
    //creates an array of player objects (which the queue will consist of) from firebase data
    static func playerArrayFromFBData(_ fbData: AnyObject) -> [Player] {
        var players = [Player]()
        if let formatted = fbData as? Dictionary<String, AnyObject> {
            for (key, playerObj) in formatted {
                let obj = playerObj as! Dictionary<String, AnyObject>
                let player = Player(in_playerId: key, playerData: obj as Dictionary<String, AnyObject>)
                players.append(player)
            }
        }
        return players
    }
}
