//
//  Player.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 6/18/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import Foundation

class Player {
    fileprivate var _queuePosition: Int?
    fileprivate var _imagePath: String
    fileprivate var _playerName: String?
    
    var queuePosition: Int? {
        return _queuePosition
    }
    
    var imagePath: String {
        return _imagePath
    }
    
    var playerName: String? {
        return _playerName
    }
    
    //regular initializer
    init(in_queuePosition: Int?, in_imagePath: String, in_playerName: String?) {
        _queuePosition = in_queuePosition
        _imagePath = in_imagePath
        _playerName = in_playerName
    }
    
    //initializes instance of a player by using firebase data in the form of a dictionary
    init(playerData: Dictionary<String, AnyObject>) {
        _queuePosition = playerData["position"] as? Int
        _imagePath = playerData["image"] as! String
        _playerName = playerData["player"] as? String
    }
}
